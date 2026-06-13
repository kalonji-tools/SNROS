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
      { pkgs, ... }:
      {
        programs.command-not-found.enable = false;
        environment.systemPackages = [ pkgs.nh ];
      };
  };

  den.default.includes = [ den.aspects.nix-helpers ];
}
