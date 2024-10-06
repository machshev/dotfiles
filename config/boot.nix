{
  config,
  pkgs,
  inputs,
  ...
}: {
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.systemd.enable = true;

  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;
}
