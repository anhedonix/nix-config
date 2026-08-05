{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      # --- Network ---
      curl # HTTP client

      # --- Editors & multiplexers ---
      neovim # modal text editor
      tmux # terminal multiplexer

      # --- System monitors ---
      htop # interactive process viewer
      btop # modern resource monitor

      # --- Files & search ---
      tree # directory tree listing
      ripgrep # fast recursive search
      zoxide # smarter cd
      eza # modern ls (used by shell aliases)
      bat # cat with syntax highlighting (shell alias)
      rm-improved # safer rm alternative as `rip` (shell alias)

      # --- Git & GitHub ---
      gh # GitHub CLI

      # --- Runtimes ---
      mise # polyglot version manager

      # --- Language tooling ---
      nil # Nix language server
      biome # JS/TS linter and formatter
      nixfmt-rfc-style # Nix formatter (RFC style)

      # --- Media ---
      yt-dlp # video/audio downloader
      ffmpeg # media conversion
      # ollama # local LLM runtime
    ];
  };
}
