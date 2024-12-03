{
  pkgs,
  lib,
  ...
}: {
  # Required because the intel GPU isn't supported well, does it work with the
  # latest?
  # boot.kernelPackages = lib.mkForce pkgs.linuxPackages_latest;

  # boot.kernelParams = [
  #   "i915.enable_psr=0"
  # ];

  # hardware.graphics.enable = true;
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
}
