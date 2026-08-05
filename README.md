# Nix Config (macOS + NixOS)

Declarative system configuration for macOS (nix-darwin) and NixOS, with a shared Home Manager layer. Containers use **Podman Desktop** on both platforms.

**Author:** Anand Magaji

## Prerequisites

### macOS

1. Install Nix with the [Determinate Systems installer](https://docs.determinate.systems/#products). Restart the terminal after install.
2. Homebrew is managed via nix-homebrew / nix-darwin (migrates an existing install if present).

### NixOS

1. Install NixOS on the machine, then replace [`hosts/tp14s/hardware-configuration.nix`](hosts/tp14s/hardware-configuration.nix) with real hardware config from `nixos-generate-config`.
2. Clone this repo and apply with the Linux switch script (below).

## Quick Start

```bash
git clone https://github.com/amagaji/nix-config.git ~/Documents/GitHub/nix-config
cd ~/Documents/GitHub/nix-config
```

### Apply configuration

```bash
# macOS (defaults: username=amagaji, hostname=macpro-m2)
./scripts/switch-mac.sh
./scripts/switch-mac.sh amagaji macpro-m2

# NixOS (defaults: username=amagaji, hostname=tp14s)
./scripts/switch-linux.sh
./scripts/switch-linux.sh amagaji tp14s
```

Scripts export `PRIMARY_USER` and rebuild with `--impure` so the username can be overridden at runtime. The hostname selects the flake attribute (`#macpro-m2` or `#tp14s`).

After the first successful switch, shell aliases `sdr` (macOS) and `snr` (Linux) point at these scripts.

## What's Included

**Shared (Home Manager):** mise, Zsh + Starship, CLI tools (curl, neovim, tmux, eza, ripgrep, gh, zoxide, …), git + SSH signing, fonts.

**macOS:** nix-darwin system settings, declarative Homebrew GUIs, Podman Desktop + `podman` CLI via Homebrew.

**NixOS:** Podman engine (`dockerCompat`), Flatpak, Podman Desktop from Flathub (`io.podman_desktop.PodmanDesktop`).

## Project Structure

```
nix-config/
├── flake.nix                      # darwinConfigurations.macpro-m2 + nixosConfigurations.tp14s
├── scripts/
│   ├── switch-mac.sh              # darwin-rebuild (user/host args)
│   └── switch-linux.sh            # nixos-rebuild (user/host args)
├── darwin/                        # macOS system modules + Homebrew
├── nixos/                         # NixOS system modules + Podman/Flatpak
├── home/                          # Shared Home Manager modules
└── hosts/
    ├── macpro-m2/                 # Mac host
    └── tp14s/                     # NixOS host (+ hardware placeholder)
```

## Customization

| Change | Where |
|--------|--------|
| CLI tools | [`home/packages.nix`](home/packages.nix) |
| Mac GUI apps | [`darwin/homebrew.nix`](darwin/homebrew.nix) |
| Dev runtimes (mise) | [`home/mise.nix`](home/mise.nix) |
| Mac host extras | [`hosts/macpro-m2/configuration.nix`](hosts/macpro-m2/configuration.nix) |
| Linux host / hardware | [`hosts/tp14s/`](hosts/tp14s/) |

## Troubleshooting

- **Wrong OS:** each switch script refuses to run on the other platform.
- **Unknown flake attr:** hostname must match an output in `flake.nix` (`macpro-m2` or `tp14s`).
- **NixOS hardware:** replace the placeholder `hardware-configuration.nix` before a real install.
- **Leftover Docker Desktop / Colima on Mac:** after switching to Podman, uninstall any non-Brew leftovers manually if Homebrew cleanup did not remove them.

## Credits

- Based on patterns from [nix-macos-starter](https://github.com/nebrelbug/nix-macos-starter) and related nix-darwin / Home Manager setups.
