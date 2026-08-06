{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Dev tools & IDEs (no Flatpak equivalent) ---
    code-cursor # Cursor AI editor
    ghostty # GPU-accelerated terminal

    # --- Editors ---
    emacs # Doom Emacs (shared config in common/dotfiles)
  ];
}
