{
  pkgs,
  lib,
  ...
}: {
  # Required because the intel GPU isn't supported well, does it work with the
  # latest?
  boot.kernelPackages = lib.mkForce pkgs.linuxPackages_6_10;

  # hardware.graphics.enable = true;
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
}
