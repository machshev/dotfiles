{pkgs, ...}: {
  # Required because the intel GPU isn't supported well, does it work with the
  # latest?
  boot.kernelPackages = pkgs.linuxPackages_6_9;

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
}
