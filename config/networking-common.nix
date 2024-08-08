{pkgs, ...}: {
  networking.networkmanager.enable = true;

  # Disable this service as it doesn't appear to be doing anything useful and on
  # the latest Nixos updates it prevents boot
  systemd.services.NetworkManager-wait-online.enable = false;

  environment.systemPackages = with pkgs; [
    networkmanager
    networkmanagerapplet
  ];

  # List services that you want to enable:

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.tailscale.enable = true;
}
