{ den, ... }:
{
  den.aspects.upgrade = {
    nixos =
      { pkgs, ... }:
      let
        # TODO(#55): restore post-deploy validation once oxitest + oxi-nixinfra
        # are available in nixpkgs
        upgradeScript = pkgs.writeShellScript "snros-upgrade" ''
          set -euo pipefail
          echo "=== SNROS upgrade started ==="
          nixos-rebuild switch --flake github:kalonji-tools/SNROS
          echo "=== SNROS upgrade complete ==="
        '';
      in
      {
        systemd.services.snros-upgrade = {
          description = "SNROS self-upgrade";
          serviceConfig = {
            Type = "oneshot";
            ExecStart = upgradeScript;
          };
          path = with pkgs; [
            nix
            git
          ];
        };
      };
    tests = { upgrade, ... }: {
      upgrade-has-nixos = {
        expr = upgrade ? nixos;
        expected = true;
      };
    };
  };

  den.default.includes = [ den.aspects.upgrade ];
}
