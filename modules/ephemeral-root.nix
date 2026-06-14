{ den, inputs, ... }:
{
  den.aspects.ephemeral-root = {
    nixos = { pkgs, ... }: {
      imports = [
        inputs.disko.nixosModules.disko
        inputs.preservation.nixosModules.preservation
      ];

      boot = {
        loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
        };

        initrd.systemd = {
          enable = true;
          services.rollback-root = {
            description = "Rollback ZFS root to blank snapshot";
            wantedBy = [ "initrd.target" ];
            before = [ "sysroot.mount" ];
            after = [ "zfs-import.target" ];
            unitConfig.DefaultDependencies = "no";
            serviceConfig = {
              Type = "oneshot";
              ExecStart = "${pkgs.zfs}/bin/zfs rollback -r zroot/root@blank";
            };
          };
        };

        supportedFilesystems = [ "zfs" ];
      };

      preservation.enable = true;

      networking.hostId = builtins.substring 0 8 (builtins.hashString "sha256" "snros");
    };
    tests = { ephemeral-root, ... }: {
      ephemeral-root-has-nixos = {
        expr = ephemeral-root ? nixos;
        expected = true;
      };
    };
  };

  den.default.includes = [ den.aspects.ephemeral-root ];
}
