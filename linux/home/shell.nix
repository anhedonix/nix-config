{ config, ... }:
let
  flakeDir = "${config.home.homeDirectory}/Documents/GitHub/nix-config";
in
{
  programs.zsh.shellAliases = {
    snr = "sudo nixos-rebuild switch --flake ${flakeDir}/linux#tp14s";
  };
}
