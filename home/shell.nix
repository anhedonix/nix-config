{
  lib,
  pkgs,
  config,
  ...
}:
let
  # Prefer the flake checkout when present; fall back to a common clone path.
  flakeDir = "${config.home.homeDirectory}/Documents/GitHub/nix-config";
  switchMac = "${flakeDir}/scripts/switch-mac.sh";
  switchLinux = "${flakeDir}/scripts/switch-linux.sh";
in
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases =
      {
        ls = "eza";
        ll = "eza -lah";
        l = "eza -lh";
        "~" = "cd ~";
        ".." = "cd ..";
        "..." = "cd ../..";
        "...." = "cd ../../..";
        cd = "z";
        git-signing-setup = "ensure-git-ssh-signing";
      }
      // lib.optionalAttrs pkgs.stdenv.hostPlatform.isDarwin {
        brew = "echo 'Homebrew is strictly managed by nix-darwin. Edit darwin/homebrew.nix instead.'";
        sdr = switchMac;
      }
      // lib.optionalAttrs pkgs.stdenv.hostPlatform.isLinux {
        snr = switchLinux;
      };

    initContent = ''
      if [[ -o interactive ]] && [[ ! -f ~/.ssh/id_ed25519_github_signing || ! -f ~/.ssh/id_ed25519_github_signing.github ]]; then
        ensure-git-ssh-signing || true
      fi
    '';
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      #      character = {
      #        success_symbol = "[λ](bold green)";
      #        error_symbol = "[λ](bold red)";
      #      };
    };
  };
}
