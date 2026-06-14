{ den, ... }:
{
  den.aspects.upgrade = {
    nixos =
      { pkgs, ... }:
      let
        testinfraEnv = pkgs.python3.withPackages (
          ps: with ps; [
            pytest
            pytest-testinfra
            paramiko
          ]
        );
        upgradeScript = pkgs.writeShellScript "snros-upgrade" ''
          set -euo pipefail
          echo "=== SNROS upgrade started ==="
          nixos-rebuild switch --flake github:kalonji-tools/SNROS
          echo "=== Running testinfra validation ==="
          ${testinfraEnv}/bin/pytest ${../tests} --tb=short -v
          echo "=== SNROS upgrade complete ==="
        '';
      in
      {
        systemd.services.snros-upgrade = {
          description = "SNROS self-upgrade with testinfra validation";
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
