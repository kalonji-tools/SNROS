{ den, ... }:
{
  den.aspects.preservation-base = {
    nixos = {
      preservation.preserveAt."/persistent" = {
        directories = [
          "/var/lib/nixos"
          "/var/lib/systemd"
          "/var/log/journal"
          "/var/lib/NetworkManager"
          "/var/lib/bluetooth"
          "/var/lib/fwupd"
        ];
        files = [
          "/etc/machine-id"
        ];
      };
    };
    tests = { preservation-base, ... }: {
      preservation-base-has-nixos = {
        expr = preservation-base ? nixos;
        expected = true;
      };
    };
  };

  den.default.includes = [ den.aspects.preservation-base ];
}
