{
  den.aspects.nix-helpers = {
    homeManager =
      { pkgs, ... }:
      {
        programs.nix-index = {
          enable = true;
          enableZshIntegration = true;
        };
        home.packages = [ pkgs.comma ];
      };
    nixos.programs.command-not-found.enable = false;
  };

  den.default.includes = [ den.aspects.nix-helpers ];
}
