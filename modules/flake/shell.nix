{
  perSystem =
    { pkgs, ... }:
    {
      devShells.default = pkgs.mkShellNoCC {
        packages = [
          pkgs.prek
          pkgs.nixfmt-rfc-style
        ];
      };
    };
}
