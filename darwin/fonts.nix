{ pkgs, ... }:
{
  fonts.packages = import ../home/font-packages.nix { inherit pkgs; };
}
