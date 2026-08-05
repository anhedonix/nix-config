{
  lib,
  pkgs,
  config,
  ...
}:
let
  flakeDir = "${config.home.homeDirectory}/Documents/GitHub/nix-config";
  link = path: config.lib.file.mkOutOfStoreSymlink "${flakeDir}/home/dotfiles/${path}";
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
in
{
  xdg.configFile = {
    "doom".source = link "doom";
    "nvim".source = link "nvim";
    "zed/settings.json".source = link "zed/settings.json";
    "gh/config.yml".source = link "gh/config.yml";
    "gh/hosts.yml".source = link "gh/hosts.yml";
    "lazygit/config.yml".source = link "lazygit/config.yml";
    "fish/config.fish".source = link "fish/config.fish";
    "fish/conf.d/rustup.fish".source = link "fish/conf.d/rustup.fish";
    "containers/containers.conf".source = link "containers/containers.conf";
  }
  // lib.optionalAttrs isDarwin {
    "karabiner/karabiner.json".source = link "karabiner/karabiner.json";
  };

  home.file = {
    ".bashrc".source = link "bash/bashrc";
    ".bash_profile".source = link "bash/bash_profile";
    ".profile".source = link "bash/profile";
    ".local/bin/install_doom_emacs.sh".source = link "bin/install_doom_emacs.sh";
  }
  // lib.optionalAttrs isDarwin {
    "Library/Application Support/Cursor/User/settings.json".source = link "cursor/settings.json";
  };

  # Clone Doom core and run `doom install` once Emacs is available.
  home.activation.installDoomEmacs = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
    if command -v emacs >/dev/null 2>&1 \
       && [ -d "$HOME/.config/doom" ] \
       && [ ! -e "$HOME/.config/emacs" ]; then
      "$HOME/.local/bin/install_doom_emacs.sh"
    fi
  '';
}
