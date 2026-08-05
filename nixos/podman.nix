{ pkgs, ... }:
{
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };

  # Do not enable virtualisation.docker — Podman is the sole container stack.

  services.flatpak.enable = true;

  # Required by Flatpak on NixOS
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "gtk";
  };

  # Install Podman Desktop from Flathub on activation.
  systemd.services.podman-desktop-flatpak = {
    description = "Install Podman Desktop via Flatpak";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    path = [ pkgs.flatpak ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
      flatpak install -y --noninteractive flathub io.podman_desktop.PodmanDesktop
    '';
  };
}
