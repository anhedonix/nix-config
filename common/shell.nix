{ config, ... }:
let
  flakeDir = "${config.home.homeDirectory}/Documents/GitHub/nix-config";
in
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ls = "eza";
      ll = "eza -lah --git";
      l = "eza -lh";
      "~" = "cd ~";
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      cd = "z";
      cat = "bat";
      cp = "cp -iv";
      mv = "mv -iv";
      rm = "rip";
      untar = "tar -zxvf";
      srz = "source ~/.zshrc";
      zvi = "nvim ${flakeDir}/common/shell.nix";
      gss = "ensure-git-ssh-signing";
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
      character = {
        success_symbol = "[λ](bold green)";
        error_symbol = "[λ](bold red)";
      };
    };
  };
}
