{pkgs, ...}: {
  networking.networkmanager.enable = true;

  # Disable this service as it doesn't appear to be doing anything useful and on
  # the latest Nixos updates it prevents boot
  systemd.services.NetworkManager-wait-online.enable = false;

  environment.systemPackages = with pkgs; [
    networkmanager
    networkmanagerapplet
  ];

  services.resolved.enable = true;
  networking.useNetworkd = true;
  networking.nftables.enable = true;

  networking.nameservers = [ "1.1.1.1" "8.8.8.8" ];

  # List services that you want to enable:
  # networking.firewall.allowedTCPPorts = [];
  # networking.firewall.allowedUDPPorts = [];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.tailscale.enable = true;
}
