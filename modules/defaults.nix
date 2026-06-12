{ lib, ... }:
{
  den = {
    default.nixos.system.stateVersion = "25.11";
    default.homeManager.home.stateVersion = "25.11";
    schema.user.classes = lib.mkDefault [ "homeManager" ];
  };
}
