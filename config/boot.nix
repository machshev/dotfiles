{
  config,
  pkgs,
  inputs,
  ...
}: {
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.enableRedistributableFirmware = true;

  fileSystems = {
    "/".options = ["compress=zstd"];
    "/home".options = ["compress=zstd"];
    "/nix".options = ["compress=zstd" "noatime"];
    #"/swap".options = [ "noatime" ];
  };

  services.btrfs.autoScrub = {
    enable = true;
    interval = "monthly";
    fileSystems = ["/"];
  };
}
