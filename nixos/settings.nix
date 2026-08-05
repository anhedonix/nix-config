{ ... }:
{
  # Align with Home Manager stateVersion in home/default.nix
  system.stateVersion = "25.05";

  time.timeZone = "UTC";

  i18n.defaultLocale = "en_US.UTF-8";

  networking.networkmanager.enable = true;

  networking.firewall.enable = true;
}
