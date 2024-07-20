{lib, pkgs, config, ...}: {
  # environment.systemPackages = [ nvidia-offload ];
  services.xserver.videoDrivers = lib.mkDefault ["intel" "nvidia"];
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [ vaapiVdpau ];
  };

  nixpkgs.config.nvidia.acceptLicense = true;
  programs.sway.extraOptions = ["--unsupported-gpu"];

  hardware.nvidia = {
    modesetting.enable = true;

    powerManagement.enable = false;
    powerManagement.finegrained = false;
    forceFullCompositionPipeline = true;

    open = false; # not supported for legacy drivers
    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
  };
}
