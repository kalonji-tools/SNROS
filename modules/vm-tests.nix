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
        vm-ephemeral-reboot = pkgs.testers.runNixOSTest {
          name = "ephemeral-reboot";
          nodes.machine =
            { ... }:
            {
              imports = [
                inputs.preservation.nixosModules.preservation
              ];
              system.stateVersion = "25.11";

              virtualisation.emptyDiskImages = [ 512 ];
              virtualisation.fileSystems."/persistent" = {
                device = "/dev/vdb";
                fsType = "ext4";
                autoFormat = true;
              };

              preservation = {
                enable = true;
                preserveAt."/persistent" = {
                  directories = [
                    "/var/lib/nixos"
                  ];
                  files = [
                    "/etc/machine-id"
                  ];
                };
              };
            };
          testScript = ''
            machine.wait_for_unit("multi-user.target")

            # Record machine-id
            machine_id = machine.succeed("cat /etc/machine-id").strip()
            assert len(machine_id) > 0, "machine-id is empty"

            # Verify preservation mounted /persistent
            machine.succeed("mountpoint /persistent")

            # Write to persistent (should survive reboot)
            machine.succeed("mkdir -p /persistent/test-dir")
            machine.succeed("echo persist > /persistent/test-dir/data.txt")

            # Persist machine-id explicitly (systemd-machine-id-commit uses
            # atomic rename which bypasses bind mounts, so we copy manually)
            machine.succeed("cp /etc/machine-id /persistent/etc/machine-id")

            # Verify /var/lib/nixos is preserved
            machine.succeed("test -d /var/lib/nixos")

            # Sync disk and simulate power-cycle (crash + start preserves disk state)
            machine.succeed("sync")
            machine.crash()
            machine.start()
            machine.wait_for_unit("multi-user.target")

            # Verify persistent data survived
            machine.succeed("test -f /persistent/test-dir/data.txt")
            result = machine.succeed("cat /persistent/test-dir/data.txt").strip()
            assert result == "persist", f"Expected 'persist', got '{result}'"

            # Verify machine-id is stable (preservation bind-mounts from /persistent)
            new_machine_id = machine.succeed("cat /etc/machine-id").strip()
            assert new_machine_id == machine_id, f"machine-id changed: {machine_id} -> {new_machine_id}"

            # Verify /var/lib/nixos survived
            machine.succeed("test -d /var/lib/nixos")

            print("vm-ephemeral-reboot: ALL CHECKS PASSED")
          '';
        };
      };
    };
}
