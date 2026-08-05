{ primaryUser, ... }:
{
  imports = [
    ./shell.nix
    ./dotfiles.nix
  ];

  home.homeDirectory = "/Users/${primaryUser}";
}
