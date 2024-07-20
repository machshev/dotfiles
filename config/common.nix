{
  config,
  pkgs,
  inputs,
  ...
}: {
  programs.direnv.enable = true;

  services.printing = {
    enable = true;
    browsing = true;
    defaultShared = true;
  };

  # Bluetooth
  services.blueman.enable = true;
  hardware.bluetooth.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  virtualisation.docker.enable = true;
  virtualisation.libvirtd.enable = true;

  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
    nerdfonts
    font-awesome
    google-fonts
    meslo-lgs-nf
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
