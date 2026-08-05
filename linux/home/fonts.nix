{ pkgs, ... }:
{
  home.packages = import ../../common/font-packages.nix { inherit pkgs; };
  fonts.fontconfig.enable = true;
}