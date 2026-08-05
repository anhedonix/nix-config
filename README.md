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
# macOS (defaults: username=amagaji, hostname=amagaji-mac)
./scripts/switch-mac.sh
./scripts/switch-mac.sh amagaji amagaji-mac

# NixOS (defaults: username=amagaji, hostname=tp14s)
./scripts/switch-linux.sh
./scripts/switch-linux.sh amagaji tp14s
```

Scripts export `PRIMARY_USER` and rebuild with `--impure` so the username can be overridden at runtime. The hostname selects the flake attribute (`#amagaji-mac` or `#tp14s`).

After the first successful switch, shell aliases `sdr` (macOS) and `snr` (Linux) point at these scripts.

## What's Included

**Shared (Home Manager):** mise, Zsh + Starship, CLI tools (curl, neovim, tmux, eza, bat, ripgrep, gh, zoxide, …), git + SSH signing, fonts, and out-of-store symlinked dotfiles (nvim, Doom, Zed, gh, lazygit, fish/bash, containers.conf).

**macOS:** nix-darwin system settings, declarative Homebrew GUIs, Podman Desktop + `podman` CLI via Homebrew, Karabiner + Cursor settings symlinks.

**NixOS:** Podman engine (`dockerCompat`), Flatpak, Podman Desktop from Flathub (`io.podman_desktop.PodmanDesktop`).

## Dotfiles

Configs live under [`home/dotfiles/`](home/dotfiles/) and are linked into `$HOME` / `~/.config` by [`home/dotfiles.nix`](home/dotfiles.nix) via `mkOutOfStoreSymlink`.

**Clone path must be** `~/Documents/GitHub/nix-config` — symlink targets are absolute paths under that checkout. Edit files in the repo; they apply immediately (no rebuild) for linked configs. Run a switch after adding or changing symlink wiring in Nix.

| Managed | Target |
|---------|--------|
| Doom Emacs user config | `~/.config/doom` |
| Neovim | `~/.config/nvim` |
| Zed settings | `~/.config/zed/settings.json` |
| GitHub CLI | `~/.config/gh/{config,hosts}.yml` |
| lazygit | `~/.config/lazygit/config.yml` |
| fish / bash / profile | `~/.config/fish/...`, `~/.bashrc`, `~/.bash_profile`, `~/.profile` |
| Podman containers.conf | `~/.config/containers/containers.conf` |
| Karabiner (macOS) | `~/.config/karabiner/karabiner.json` |
| Cursor settings (macOS) | `~/Library/Application Support/Cursor/User/settings.json` |

Shell, git, mise, and Starship stay as native Home Manager options (not file copies from the old `~/dotfiles` tree). After a successful switch you can retire `~/dotfiles`.

**Doom Emacs:** After Emacs is on your `PATH` and `~/.config/doom` is linked, the next Home Manager switch runs `~/.local/bin/install_doom_emacs.sh` once (clones Doom into `~/.config/emacs` and runs `doom install`). Later switches skip this if `~/.config/emacs` already exists.

**First switch:** Home Manager refuses to overwrite existing non-HM files. Back up or remove conflicting paths (e.g. `~/.config/zed`, `~/.config/gh`, `~/.config/karabiner`, `~/.config/doom` if they are not already HM-managed) before applying.

## Project Structure

```
nix-config/
├── flake.nix                      # darwinConfigurations.amagaji-mac + nixosConfigurations.tp14s
├── scripts/
│   ├── switch-mac.sh              # darwin-rebuild (user/host args)
│   └── switch-linux.sh            # nixos-rebuild (user/host args)
├── darwin/                        # macOS system modules + Homebrew
├── nixos/                         # NixOS system modules + Podman/Flatpak
├── home/                          # Shared Home Manager modules
│   └── dotfiles/                  # Symlinked configs (nvim, doom, zed, …)
└── hosts/
    ├── amagaji-mac/                 # Mac host
    └── tp14s/                     # NixOS host (+ hardware placeholder)
```

## Customization

| Change | Where |
|--------|--------|
| CLI tools | [`home/packages.nix`](home/packages.nix) |
| Symlinked configs | [`home/dotfiles/`](home/dotfiles/) + [`home/dotfiles.nix`](home/dotfiles.nix) |
| Mac GUI apps | [`darwin/homebrew.nix`](darwin/homebrew.nix) |
| Dev runtimes (mise) | [`home/mise.nix`](home/mise.nix) |
| Mac host extras | [`hosts/amagaji-mac/configuration.nix`](hosts/amagaji-mac/configuration.nix) |
| Linux host / hardware | [`hosts/tp14s/`](hosts/tp14s/) |

## Troubleshooting

- **Wrong OS:** each switch script refuses to run on the other platform.
- **Unknown flake attr:** hostname must match an output in `flake.nix` (`amagaji-mac` or `tp14s`).
- **NixOS hardware:** replace the placeholder `hardware-configuration.nix` before a real install.
- **Leftover Docker Desktop / Colima on Mac:** after switching to Podman, uninstall any non-Brew leftovers manually if Homebrew cleanup did not remove them.
- **Dotfile symlink conflicts:** remove or rename existing target files/dirs, then re-run the switch script.
- **Broken out-of-store links:** ensure the repo is checked out at `~/Documents/GitHub/nix-config`.

## Credits

- Based on patterns from [nix-macos-starter](https://github.com/nebrelbug/nix-macos-starter) and related nix-darwin / Home Manager setups.
