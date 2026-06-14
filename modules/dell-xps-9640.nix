{ den, mkDiskoConfig, ... }:
{
  den = {
    hosts.x86_64-linux.dell-xps-9640.users.snregales = { };

    aspects.dell-xps-9640 = {
      nixos = {
        hardware.facter.reportPath = ../hosts/dell-xps-9640/facter.json;

        disko.devices = mkDiskoConfig {
          device = "/dev/nvme0n1";
          luksAuth = "passphrase";
          espSize = "512M";
        };

        users.users.snregales = {
          isNormalUser = true;
          extraGroups = [
            "wheel"
            "networkmanager"
          ];
          group = "snregales";
        };
        users.groups.snregales = { };

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
