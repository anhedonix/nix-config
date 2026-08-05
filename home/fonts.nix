{ pkgs, lib, ... }:
lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
  home.packages = import ./font-packages.nix { inherit pkgs; };
  fonts.fontconfig.enable = true;
}
