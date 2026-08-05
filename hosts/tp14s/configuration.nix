{ ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "tp14s";

  # Bootloader — adjust on the real machine if needed after nixos-generate-config.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}
