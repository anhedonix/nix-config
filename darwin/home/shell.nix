{ config, ... }:
let
  flakeDir = "${config.home.homeDirectory}/Documents/GitHub/nix-config";
in
{
  programs.zsh.shellAliases = {
    brew = "echo 'Homebrew is strictly managed by nix-darwin. Edit darwin/homebrew.nix instead.'";
    # Ensure HM profiles dir exists (Determinate Nix often omits the global one).
    sdr = "mkdir -p ~/.local/state/nix/profiles && sudo darwin-rebuild switch --flake ${flakeDir}/darwin#amagaji-mac";
  };
}
