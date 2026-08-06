{ pkgs, ... }:
{
  # Required by Flatpak on NixOS
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "gtk";
  };

  # Declarative Flatpaks (mirrors darwin/homebrew.nix GUI apps where Flathub has them).
  # uninstallUnmanaged mirrors brew cleanup = "uninstall".
  services.flatpak = {
    enable = true;
    uninstallUnmanaged = true;
    packages = [
      # --- Containers ---
      "io.podman_desktop.PodmanDesktop" # Podman GUI

      # --- Dev tools & IDEs ---
      "com.visualstudio.code" # VS Code
      "dev.zed.Zed" # fast collaborative editor
      "io.github.shiftey.Desktop" # GitHub Desktop (Linux fork)
      "com.axosoft.GitKraken" # Git GUI client

      # --- Messaging ---
      "com.discordapp.Discord" # chat and communities
      "com.slack.Slack" # team chat
      "org.signal.Signal" # encrypted messaging
      "com.rtosta.zapzap" # WhatsApp (ZapZap)

      # --- Security ---
      "com.onepassword.OnePassword" # password manager

      # --- Browsers ---
      "com.brave.Browser" # privacy-focused browser
      "app.zen_browser.zen" # Firefox-based browser

      # --- Knowledge & notes ---
      "net.ankiweb.Anki" # spaced-repetition flashcards
      "org.freeplane.App" # mind mapping
      "md.obsidian.Obsidian" # markdown knowledge base

      # --- Media & downloads ---
      "org.jdownloader.JDownloader" # download manager
      "com.spotify.Client" # music streaming

      # --- Helpers ---
      "com.github.tchx84.Flatseal" # Flatpak permission editor
    ];
  };
}
