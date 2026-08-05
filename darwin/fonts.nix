{ pkgs, ... }:
{
  fonts.packages = import ../common/font-packages.nix { inherit pkgs; };
}
