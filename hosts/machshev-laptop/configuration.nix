# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../config/boot.nix
      ../../config/common.nix
      ../../config/display-manager.nix
      ../../config/gpu-nvidia.nix
      ../../config/input.nix
      ../../config/locals.nix
      ../../config/networking-common.nix
      ../../config/wol.nix
      ../../config/nix.nix
      ../../config/security.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub = {
    enable = true;
    zfsSupport = true;
    efiSupport = true;
    efiInstallAsRemovable = true;
    mirroredBoots = [
      { devices = [ "nodev"]; path = "/boot"; }
    ];
  };

  networking.hostName = "machshev-laptop"; # Define your hostname.
  networking.hostId = "adee2521";

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

  system.stateVersion = "23.11"; # Did you read the comment?

}

