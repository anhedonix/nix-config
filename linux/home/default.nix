{ primaryUser, ... }:
{
  imports = [
    ./shell.nix
    ./fonts.nix
  ];

  home.homeDirectory = "/home/${primaryUser}";
}
