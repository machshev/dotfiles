# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  fileSystems = {
    "/".options = [ "compress=zstd" ];
    "/home".options = [ "compress=zstd" ];
    "/nix".options = [ "compress=zstd" "noatime" ];
    #"/swap".options = [ "noatime" ];
  };

  services.btrfs.autoScrub = {
    enable = true;
    interval = "monthly";
    fileSystems = [ "/" ];
  };

  networking.hostName = "machshev";
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # NVIDIA
  nixpkgs.config.nvidia.acceptLicense = true;

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
    modesetting.enable = true;
    open = false;
  };

  services.xserver.videoDrivers = [ "modesetting" "nvidiaLegacy470" ];

  # X11
  services.xserver.enable = true;

  services.xserver.xkb.layout = "us";
  services.xserver.xkb.variant = "";

  services.xserver.displayManager.lightdm.enable = true;


  # Hyprland
  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;

  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };

  nixpkgs.overlays = [
    (self: super: {
      waybar = super.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true" "-Dmpd=enabled"];
      });
    })
  ];

  # Fix electron apps in wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  services.printing = {
    enable = true;
    browsing = true;
    defaultShared = true;
  };

  # Bluetooth
  services.blueman.enable = true;
  hardware.bluetooth.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # touchpad support
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.david = {
    isNormalUser = true;
    description = "David James McCorrie";
    extraGroups = [ "networkmanager" "wheel" "dialout" "video" "kvm"];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
        "david" = import ./home.nix;
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    alacritty
    starship
    stow
    blueman
    fzf
    fd
    bandwhich
    grex
    broot
    delta
    bingrep
    #basic-http-server
    git
    gnome3.cheese
    vlc
    bat
    dutree
    gitui
    hyperfine
    tokei
    tealdeer
    ripgrep
    tmux
    procs
    ranger
    skim
    screen
    zoxide
    bottom
    eza
    #git-delta
    nodejs
    gcc
    clang
    go
    php
    phpactor
    asm-lsp
    typos-lsp
    cargo
    rustc
    openssl.dev
    mosh
    neovim
    firefox-wayland
    wlr-randr
    wl-clipboard
    waybar
    wget
    wayvnc
    xwayland
    hyprland-protocols
    hyprpicker
    swayidle
    swaylock
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    xdg-utils
    hyprpaper
    wofi
    wlroots
    qt5.qtwayland
    qt6.qmake
    qt6.qtwayland
    gparted
    gimp
    ansible
    v4l-utils
    #speech-dispatcher
    #speech-dispatcher-utils
    ydotool
    xdotool
    grim
    slurp
    bemenu
    inkscape
    blender
    ninja
    dunst
    #xbacklight
    feh
    conky
    maim
    conky
    xclip
    unzip
  ];

  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
    nerdfonts
    font-awesome
    google-fonts
    meslo-lgs-nf
  ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  environment.sessionVariables = {
    POLKIT_AUTH_AGENT = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
    GSETTINGS_SCHEMA_DIR = "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}/glib-2.0/schemas";
    XDG_SESSION_TYPE = "wayland";
    WLR_NO_HARDWARE_CURSORS = "1";
    MOZ_ENABLE_WAYLAND = "1";
    SDL_VIDEODRIVER = "wayland";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    CLUTTER_BACKEND = "wayland";
    WLR_RENDERER = "vulkan";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    GTK_USE_PORTAL = "1";
    NIXOS_XDG_OPEN_USE_PORTAL = "1";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
