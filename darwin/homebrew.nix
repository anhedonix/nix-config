{
  lib,
  config,
  pkgs,
  ...
}:
{
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "uninstall";
    };

    # caskArgs.no_quarantine = true; # causes installation issues
    global.brewfile = true;

    # homebrew is best for GUI apps
    # nixpkgs is best for CLI tools
    casks = [
      # --- Window management & desktop ---
      # "aerospace" # tiling window manager
      "hiddenbar" # menu bar icon hider
      "raycast" # launcher and productivity
      "karabiner-elements" # keyboard remapper

      # --- Display & capture ---
      "betterdisplay" # display scaling and control
      "cleanshot" # screenshot and screen recording

      # --- Design ---
      "figma@beta" # UI/UX design (beta)

      # --- Dev tools & IDEs ---
      "cursor" # AI code editor
      "podman-desktop" # Podman GUI and engine
      "ghostty" # GPU-accelerated terminal
      "visual-studio-code" # code editor
      "zed" # fast collaborative editor
      "github" # GitHub Desktop
      "git-credential-manager" # Git credential helper
      # "opencode-desktop" # OpenCode desktop app
      # "lm-studio" # local LLM studio
      # "mactex-no-gui" # TeX distribution (no GUI)
      "gitkraken" # Git GUI client

      # --- Networking & remote ---
      # "tailscale-app" # mesh VPN client
      # "rustdesk" # remote desktop
      # "kde-connect" # phone-desktop sync
      # "protonvpn" # VPN client

      # --- Messaging ---
      "discord" # chat and communities
      "slack@beta" # team chat (beta)
      "signal" # encrypted messaging

      # --- Security ---
      "1password" # password manager

      # --- Browsers ---
      "brave-browser" # privacy-focused browser
      "zen" # Firefox-based browser
      # "thebrowsercompany-dia" # Dia browser

      # --- Knowledge & notes ---
      "anki" # spaced-repetition flashcards
      "freeplane" # mind mapping
      "obsidian" # markdown knowledge base

      # --- Media & downloads ---
      "jdownloader" # download manager
      "spotify" # music streaming
    ];

    brews = [
      # --- Containers ---
      "podman" # Podman CLI (Brew-only; pairs with podman-desktop cask)

      # --- Formatting ---
      "prettier" # code formatter
    ];

    taps = [ ];

    masApps = {
      # --- Mac App Store ---
      "WhatsApp" = 310633997; # messaging
      "GoodNotes3" = 1444383602; # handwriting notes
      # "Tailscale" = 1475387142; # mesh VPN
    };
  };

  # Skip already-installed MAS apps (HOMEBREW_BUNDLE_MAS_SKIP) while keeping
  # them in the Brewfile so cleanup = "uninstall" does not remove them.
  # Missing apps still install; casks/brews still upgrade (upgrade = true).
  system.activationScripts.homebrew.text = lib.mkForce ''
    echo >&2 "Homebrew bundle..."
    if [ -f "${config.homebrew.prefix}/bin/brew" ]; then
      skip=""
      installed="$(${lib.getExe pkgs.mas} list 2>/dev/null | awk '{print $1}' || true)"
      for id in ${lib.concatMapStringsSep " " toString (lib.attrValues config.homebrew.masApps)}; do
        if printf '%s\n' "$installed" | grep -qx "$id"; then
          skip="$skip $id"
        fi
      done
      skip="$(echo "$skip" | xargs)"
      ${lib.replaceStrings [ " env " ] [
        " env HOMEBREW_BUNDLE_MAS_SKIP=\"$skip\" "
      ] (config.homebrew.onActivation.brewBundleCmd { onlyCheck = false; })}
    else
      echo -e "\e[1;31merror: Homebrew is not installed, skipping...\e[0m" >&2
    fi
  '';
}
