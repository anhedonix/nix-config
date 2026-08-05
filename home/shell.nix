_: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ls = "eza";
      ll = "eza -lah";
      l = "eza -lh";
      "~" = "cd ~";
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      cd = "z";
      brew = "echo 'Homebrew is strictly managed by nix-darwin. Edit flake.nix instead.'";
      sdr = "sudo darwin-rebuild switch --flake ~/nix-dotfiles";
      git-signing-setup = "ensure-git-ssh-signing";
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
