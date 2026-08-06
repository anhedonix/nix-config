{
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };

  # Do not enable virtualisation.docker — Podman is the sole container stack.
  # Podman Desktop Flatpak is declared in flatpak.nix.
}
