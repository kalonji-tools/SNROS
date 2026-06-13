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
  };

  den.default.includes = [ den.aspects.nix-helpers ];
}
