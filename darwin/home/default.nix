{ primaryUser, ... }:
{
  imports = [
    ./shell.nix
    ./dotfiles.nix
    ./wallpaper.nix
  ];

  home.homeDirectory = "/Users/${primaryUser}";
}
