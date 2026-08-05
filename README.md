# nix-config

Declarative system configuration for **macOS** (nix-darwin) and **NixOS**, with a shared Home Manager layer in `common/`. Containers use **Podman Desktop** on both platforms (not Docker Desktop).

This is a customized fork by [Anand Magaji](https://magaji.dev).

## Getting started

Clone path must be `~/Documents/GitHub/nix-config` — out-of-store dotfile symlinks and rebuild aliases use that absolute path.

```bash
mkdir -p ~/Documents/GitHub
git clone https://github.com/anhedonix/nix-config.git ~/Documents/GitHub/nix-config
cd ~/Documents/GitHub/nix-config
```

### macOS

```bash
# 1) Install Nix (Determinate). Restart the terminal afterward.
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

# 2) Optional but recommended before first switch: back up conflicting paths
#    e.g. ~/.config/{doom,nvim,zed,gh,lazygit,karabiner,fish} ~/.bashrc ~/.bash_profile ~/.profile

# 3) Apply the system + Home Manager config
darwin-rebuild switch --flake ~/Documents/GitHub/nix-config/darwin#amagaji-mac

# 4) Reload the shell (or open a new terminal)
exec zsh
# later rebuilds: sdr
```

Homebrew is managed by nix-homebrew / nix-darwin (migrates an existing install if present). The Darwin flake sets `nix.enable = false` so the Determinate installer owns Nix.

### NixOS

```bash
# 1) On a fresh install, generate real hardware config and replace the placeholder
sudo nixos-generate-config --show-hardware-config > linux/hosts/tp14s/hardware-configuration.nix

# 2) Optional: back up conflicting home paths (same idea as macOS)

# 3) Apply
sudo nixos-rebuild switch --flake ~/Documents/GitHub/nix-config/linux#tp14s

# 4) Reload the shell
exec zsh
# later rebuilds: snr
```

### After the first switch

- **Git SSH signing:** run `gss` (or `ensure-git-ssh-signing`) if needed; interactive zsh also auto-runs it when the signing key/marker is missing.
- **mise:** activation installs global tools (`node@lts`, `bun@latest`, `uv@latest`, `rust@stable`).
- **Doom Emacs:** once `emacs` is on your `PATH` and `~/.config/doom` is linked, the next switch runs a one-shot install into `~/.config/emacs`.

## How it works

```mermaid
flowchart LR
  rebuildMac["darwin-rebuild --flake darwin#amagaji-mac"] --> darwinFlake["darwin/flake.nix"]
  rebuildLinux["nixos-rebuild --flake linux#tp14s"] --> linuxFlake["linux/flake.nix"]
  darwinFlake --> darwinMods["darwin modules + host"]
  linuxFlake --> linuxMods["linux modules + host"]
  darwinMods --> common["common/ Home Manager"]
  linuxMods --> common
```

| Layer | Role |
|-------|------|
| [`darwin/flake.nix`](darwin/flake.nix) | macOS output `amagaji-mac`; user hardcoded as `amagaji` |
| [`linux/flake.nix`](linux/flake.nix) | NixOS output `tp14s`; user hardcoded as `amagaji` |
| [`darwin/`](darwin/) | macOS system modules, nix-homebrew, Mac-only HM + dotfiles |
| [`linux/`](linux/) | NixOS system modules, Podman + Flatpak Podman Desktop, Linux-only HM |
| [`common/`](common/) | Shared Home Manager: packages, shell, git, mise, shared dotfiles |

Username and hostnames are baked into each flake (no env overrides, no `--impure`).

Dotfiles under [`common/dotfiles/`](common/dotfiles/) (and Mac-only under [`darwin/dotfiles/`](darwin/dotfiles/)) are linked with `mkOutOfStoreSymlink`, so edits in the repo apply immediately. Shell, git, mise, and Starship are native Home Manager options (a rebuild is required for those).

## Repository layout

```
nix-config/
├── common/                        # Shared Home Manager modules + dotfiles
├── darwin/                        # macOS flake + modules + host
│   ├── flake.nix
│   ├── home/                      # Mac-only HM (sdr, brew stub, Mac links)
│   ├── dotfiles/                  # karabiner, cursor, containers.conf
│   └── hosts/amagaji-mac/
└── linux/                         # NixOS flake + modules + host
    ├── flake.nix
    ├── home/                      # Linux-only HM (snr, fonts)
    └── hosts/tp14s/
```

## Day-to-day commands

| Command | Platform | Purpose |
|---------|----------|---------|
| `sdr` | macOS | `darwin-rebuild switch --flake …/darwin#amagaji-mac` |
| `snr` | Linux | `sudo nixos-rebuild switch --flake …/linux#tp14s` |
| `gss` | both | Ensure GitHub SSH commit signing (`ensure-git-ssh-signing`) |
| `zvi` | both | Edit `common/shell.nix` in neovim |
| `srz` | both | `source ~/.zshrc` |
| `ls` / `ll` / `l` | both | `eza` variants |
| `cd` | both | `z` (zoxide) |
| `cat` | both | `bat` |
| `rm` | both | `rip` (rm-improved) |
| `cp` / `mv` | both | interactive (`-iv`) |
| `~` `..` `...` `....` | both | navigation shortcuts |
| `untar` | both | `tar -zxvf` |
| `brew` | macOS | Stub — edit [`darwin/homebrew.nix`](darwin/homebrew.nix) instead |

Starship prompt uses a `λ` character for success/error.

## Default installed software

### CLI (nixpkgs, both platforms)

From [`common/packages.nix`](common/packages.nix): `curl`, `neovim`, `tmux`, `htop`, `btop`, `tree`, `ripgrep`, `zoxide`, `eza`, `bat`, `rm-improved`, `gh`, `mise`, `nil`, `biome`, `nixfmt-rfc-style`, `yt-dlp`, `ffmpeg`.

macOS host extra ([`darwin/hosts/amagaji-mac/configuration.nix`](darwin/hosts/amagaji-mac/configuration.nix)): `graphite-cli`.

### mise globals

`node@lts`, `bun@latest`, `uv@latest`, `rust@stable`.

### macOS Homebrew

From [`darwin/homebrew.nix`](darwin/homebrew.nix):

| Kind | Packages |
|------|----------|
| Casks | Hidden Bar, Raycast, Karabiner-Elements, BetterDisplay, CleanShot, Figma beta, Cursor, Podman Desktop, Ghostty, VS Code, Zed, GitHub Desktop, Git Credential Manager, Discord, Slack beta, Signal, 1Password, Brave, Zen, Anki, Freeplane, Obsidian, JDownloader, Spotify |
| Brews | `podman`, `prettier` |
| Tap | `nikitabobko/tap` (Aerospace; cask commented out) |
| MAS | WhatsApp, GoodNotes3 |

### NixOS containers

Podman with `dockerCompat` (no Docker daemon) and Flatpak Podman Desktop (`io.podman_desktop.PodmanDesktop`) via [`linux/podman.nix`](linux/podman.nix).

### Fonts

DejaVu; Nerd Fonts (Iosevka, Fira Code, Fira Mono, Go Mono, JetBrains Mono, Sauce Code Pro); Source Code Pro.

### Managed dotfiles

Shared configs live under [`common/dotfiles/`](common/dotfiles/) and are linked by [`common/dotfiles.nix`](common/dotfiles.nix). Mac-only configs are under [`darwin/dotfiles/`](darwin/dotfiles/).

| Managed | Target |
|---------|--------|
| Doom Emacs user config | `~/.config/doom` |
| Neovim | `~/.config/nvim` |
| Zed settings | `~/.config/zed/settings.json` |
| GitHub CLI | `~/.config/gh/{config,hosts}.yml` |
| lazygit | `~/.config/lazygit/config.yml` |
| fish / bash / profile | `~/.config/fish/...`, `~/.bashrc`, `~/.bash_profile`, `~/.profile` |
| Podman containers.conf (macOS) | `~/.config/containers/containers.conf` |
| Karabiner (macOS) | `~/.config/karabiner/karabiner.json` |
| Cursor settings (macOS) | `~/Library/Application Support/Cursor/User/settings.json` |

**First switch:** Home Manager refuses to overwrite existing non-HM files. Back up or remove conflicting paths before applying.

## Customization

| Change | Where |
|--------|--------|
| CLI tools | [`common/packages.nix`](common/packages.nix) |
| Shared configs | [`common/dotfiles/`](common/dotfiles/) |
| Mac GUI apps | [`darwin/homebrew.nix`](darwin/homebrew.nix) |
| Dev runtimes (mise) | [`common/mise.nix`](common/mise.nix) |
| Mac host extras | [`darwin/hosts/amagaji-mac/`](darwin/hosts/amagaji-mac/) |
| Linux host / hardware | [`linux/hosts/tp14s/`](linux/hosts/tp14s/) |

## Troubleshooting

- **Unknown flake attr:** use `darwin#amagaji-mac` or `linux#tp14s`.
- **NixOS hardware:** replace the placeholder `hardware-configuration.nix` before a real install.
- **Leftover Docker Desktop / Colima on Mac:** after switching to Podman, uninstall any non-Brew leftovers manually if needed.
- **Dotfile symlink conflicts:** remove or rename existing target files/dirs, then re-run the rebuild.
- **Broken out-of-store links:** ensure the repo is checked out at `~/Documents/GitHub/nix-config`.

## Credits

Customized fork by [Anand Magaji](https://magaji.dev), based on [bgub/nix-macos-starter](https://github.com/bgub/nix-macos-starter).
