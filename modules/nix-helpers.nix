{ den, ... }:
{
  den.aspects.nix-helpers = {
    homeManager =
      { pkgs, ... }:
      {
        programs.nix-index = {
          enable = true;
          enableZshIntegration = true;
        };
        home.packages = with pkgs; [
          comma
          manix
        ];
      };
    nixos =
      {
        pkgs,
        config,
        lib,
        ...
      }:
      {
        programs.command-not-found.enable = false;
        environment.systemPackages = [ pkgs.nh ];
        preservation.preserveAt."/persistent" = lib.mkIf (config ? preservation) {
          users.snregales.directories = [
            ".cache/nix-index"
          ];
        };
      };
    tests = { nix-helpers, ... }: {
      nix-helpers-has-homeManager = {
        expr = nix-helpers ? homeManager;
        expected = true;
      };
      nix-helpers-has-nixos = {
        expr = nix-helpers ? nixos;
        expected = true;
      };
    };
  };

  den.default.includes = [ den.aspects.nix-helpers ];
}
