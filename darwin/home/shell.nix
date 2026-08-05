{ config, ... }:
let
  flakeDir = "${config.home.homeDirectory}/Documents/GitHub/nix-config";
in
{
  programs.zsh.shellAliases = {
    brew = "echo 'Homebrew is strictly managed by nix-darwin. Edit darwin/homebrew.nix instead.'";
    sdr = "darwin-rebuild switch --flake ${flakeDir}/darwin#amagaji-mac";
  };
}
