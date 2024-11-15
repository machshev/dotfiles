{pkgs, inputs, ...}: {
  programs.direnv.enable = true;

  services.printing = {
    enable = true;
    browsing = true;
    defaultShared = true;
  };

  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [
      "--update-input"
      "nixpkgs"
      "--no-write-lock-file"
      "-L" # print build logs
    ];
    dates = "02:00";
    randomizedDelaySec = "45min";
  };

  # Bluetooth
  services.blueman.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Enable sound with pipewire.
  sound.enable = false; # not using Alsa system
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.pipewire.extraConfig.pipewire."92-low-latency" = {
    "context.properties" = {
      "default.clock.rate" = 48000;
      "default.clock.allowed-rates" = [48000 44100 88200 96000 192000];
      "default.clock.quantum" = 2048;
      "default.clock.min-quantum" = 1024;
      "default.clock.max-quantum" = 4096;
    };
  };

  # services.pipewire.wireplumber.extraConfig."10-bluez" = {
  #   "monitor.bluez.properties" = {
  #     "bluez5.enable-sbc-xq" = true;
  #     "bluez5.enable-msbc" = true;
  #     "bluez5.enable-hw-volume" = true;
  #     "bluez5.roles" = [
  #       "hsp_hs"
  #       "hsp_ag"
  #       "hfp_hf"
  #       "hfp_ag"
  #     ];
  #   };
  # };

  virtualisation.docker.enable = true;
  virtualisation.libvirtd.enable = true;

  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
    nerdfonts
    font-awesome
    google-fonts
    meslo-lgs-nf
    corefonts
    vistafonts
  ];

  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  # Here because it needs to be installed as a system package at the moment
  # until I can work out how to install it via homemanager. Perhaps use a
  # devshell instead.
  environment.systemPackages = with pkgs; [
    segger-jlink
  ];

  nixpkgs.config = {
    permittedInsecurePackages = [
      "segger-jlink-qt4-796s"
      "segger-jlink-qt4-794l"
    ];
    segger-jlink.acceptLicense = true;
  };
}
