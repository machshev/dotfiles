{
  config,
  pkgs,
  inputs,
  ...
}: {
  hardware.graphics.enable = true;

  # environment.systemPackages = [ nvidia-offload ];
  services.xserver.videoDrivers = ["nvidia"];

  nixpkgs.config.nvidia.acceptLicense = true;
  programs.sway.extraOptions = ["--unsupported-gpu"];

  hardware.nvidia = {
    modesetting.enable = true;

    powerManagement.enable = true;
    powerManagement.finegrained = false;
    forceFullCompositionPipeline = true;

    open = false;

    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
  };
}
