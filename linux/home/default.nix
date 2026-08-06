{ primaryUser, ... }:
{
  imports = [
    ./shell.nix
    ./fonts.nix
    ./packages.nix
  ];

  home.homeDirectory = "/home/${primaryUser}";
}
