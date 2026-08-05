{ pkgs }:
with pkgs; [
  # --- Base ---
  dejavu_fonts # general-purpose Unicode fonts

  # --- Nerd Fonts ---
  nerd-fonts.iosevka # slim monospace with icons
  nerd-fonts.fira-code # ligature coding font with icons
  nerd-fonts.fira-mono # Fira Mono with icons
  nerd-fonts.go-mono # Go Mono with icons
  nerd-fonts.jetbrains-mono # JetBrains Mono with icons
  nerd-fonts.sauce-code-pro # Source Code Pro with icons

  # --- Coding ---
  source-code-pro # Adobe Source Code Pro
]
