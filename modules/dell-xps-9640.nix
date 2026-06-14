{ den, ... }:
{
  den = {
    hosts.x86_64-linux.dell-xps-9640.users.snregales = { };

    aspects.dell-xps-9640 = {
      nixos = {
        hardware.facter.reportPath = ../hosts/dell-xps-9640/facter.json;

        disko.devices = {
          disk.root = {
            type = "disk";
            device = "/dev/nvme0n1";
            content = {
              type = "gpt";
              partitions = {
                ESP = {
                  size = "512M";
                  type = "EF00";
                  content = {
                    type = "filesystem";
                    format = "vfat";
                    mountpoint = "/boot";
                    mountOptions = [ "umask=0077" ];
                  };
                };
                luks = {
                  size = "100%";
                  content = {
                    type = "luks";
                    name = "cryptroot";
                    settings.allowDiscards = true;
                    content = {
                      type = "zfs";
                      pool = "zroot";
                    };
                  };
                };
              };
            };
          };
          zpool.zroot = {
            type = "zpool";
            rootFsOptions = {
              mountpoint = "none";
              compression = "zstd";
              acltype = "posixacl";
              xattr = "sa";
            };
            options.ashift = "12";
            datasets = {
              root = {
                type = "zfs_fs";
                mountpoint = "/";
                options.mountpoint = "legacy";
                postCreateHook = "zfs list -t snapshot -H -o name | grep -E '^zroot/root@blank$' || zfs snapshot zroot/root@blank";
              };
              nix = {
                type = "zfs_fs";
                mountpoint = "/nix";
                options.mountpoint = "legacy";
              };
              persistent = {
                type = "zfs_fs";
                mountpoint = "/persistent";
                options.mountpoint = "legacy";
              };
            };
          };
        };

        services.getty.autologinUser = "snregales";

        preservation.preserveAt."/persistent" = {
          users.snregales.directories = [
            "Projects"
          ];
        };
      };
      tests =
        { dell-xps-9640, ... }:
        {
          dell-xps-9640-has-nixos = {
            expr = dell-xps-9640 ? nixos;
            expected = true;
          };
        };
    };

    default.includes = [ den.aspects.dell-xps-9640 ];
  };
}
