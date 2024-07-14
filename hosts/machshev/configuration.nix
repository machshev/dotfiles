# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../config/boot.nix
    ../../config/common.nix
    ../../config/display-manager.nix
    ../../config/gpu-nvidia.nix
    ../../config/input.nix
    ../../config/locals.nix
    ../../config/networking-common.nix
    ../../config/nix.nix
    ../../config/security.nix
  ];

  networking.hostName = "machshev";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.david = {
    isNormalUser = true;
    description = "David James McCorrie";
    extraGroups = [
      "networkmanager"
      "dialout"
      "plugdev"
      "whireshark"
      "wheel"
      "tty"
      "video"
      "kvm"
      "docker"
      "libvirtd"
    ];
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "david" = import ./home.nix;
    };
  };

  machshev.applyUdevRules = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;

  # List services that you want to enable:

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
