{ inputs, ... }:
{
  imports = [
    (inputs.flake-file.flakeModules.dendritic or { })
    (inputs.den.flakeModules.dendritic or { })
  ];

  flake-file.inputs = {
    den.url = "github:denful/den";
    flake-file.url = "github:vic/flake-file";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    preservation.url = "github:nix-community/preservation";
    oxitest.url = "github:kalonji-tools/oxitest";
    oxi-nixinfra = {
      url = "github:kalonji-tools/oxi-nixinfra";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        oxitest.follows = "oxitest";
      };
    };
  };
}
