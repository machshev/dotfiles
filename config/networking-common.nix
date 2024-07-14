{
  config,
  pkgs,
  inputs,
  ...
}: {
  networking.networkmanager.enable = true;

  environment.systemPackages = with pkgs; [
    networkmanager
    networkmanagerapplet
  ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.tailscale.enable = true;
}
