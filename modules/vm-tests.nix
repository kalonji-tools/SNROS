{ inputs, mkDiskoConfig, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      checks = {
        vm-minimal-boot = pkgs.testers.runNixOSTest {
          name = "minimal-boot";
          nodes.machine = {
            system.stateVersion = "25.11";
          };
          testScript = ''
            machine.wait_for_unit("default.target")
            machine.succeed("nixos-rebuild --help")
          '';
        };

        vm-disko-format = pkgs.testers.runNixOSTest {
          name = "disko-format";
          nodes.machine =
            { pkgs, ... }:
            {
              imports = [ inputs.disko.nixosModules.disko ];
              system.stateVersion = "25.11";

              environment.systemPackages = with pkgs; [
                cryptsetup
                util-linux
                zfs
              ];

              disko = {
                enableConfig = false;
                checkScripts = true;
                devices = mkDiskoConfig {
                  device = "/dev/vdb";
                  luksAuth = "keyfile";
                  espSize = "256M";
                };
              };

              virtualisation.emptyDiskImages = [ 4096 ];

              networking.hostId = builtins.substring 0 8 (builtins.hashString "sha256" "snros");
              boot.supportedFilesystems = [ "zfs" ];
              boot.zfs.devNodes = "/dev";

              nix.settings = {
                substituters = pkgs.lib.mkForce [ ];
                connect-timeout = 1;
              };
              documentation.enable = false;
            };
          testScript =
            { nodes, ... }:
            ''
              machine.wait_for_unit("default.target")

              # Create LUKS keyfile
              machine.succeed("echo -n testpassword > /tmp/luks-pass")

              # Run disko to format and mount /dev/vdb
              machine.succeed("${pkgs.lib.getExe nodes.machine.system.build.destroyFormatMount} --yes-wipe-all-disks")

              # Verify LUKS is open
              machine.succeed("cryptsetup status cryptroot")

              # Verify ZFS pool imported
              machine.succeed("zpool status zroot")

              # Verify datasets exist
              machine.succeed("zfs list zroot/root")
              machine.succeed("zfs list zroot/nix")
              machine.succeed("zfs list zroot/persistent")

              # Verify blank snapshot exists
              machine.succeed("zfs list -t snapshot zroot/root@blank")

              # Verify ESP is vfat
              machine.succeed("blkid /dev/vdb1 | grep vfat")

              print("vm-disko-format: ALL CHECKS PASSED")
            '';
        };
      };
    };
}
