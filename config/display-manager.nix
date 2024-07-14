{
  lib,
  pkgs,
  ...
}: {
  xdg.portal = lib.mkForce {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  # X11
  services.xserver.enable = true;

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;

  # Hyprland
  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;

  # Sway
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  nixpkgs.overlays = [
    (self: super: {
      waybar = super.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true" "-Dmpd=enabled"];
      });
    })
  ];

  services.dbus.enable = true;

  environment.systemPackages = with pkgs; [
    wlroots
    xwayland
    wlr-randr
    qt5.qtwayland
    qt6.qmake
    qt6.qtwayland
  ];

  environment.sessionVariables = {
    CLUTTER_BACKEND = "wayland";
    GSETTINGS_SCHEMA_DIR = "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}/glib-2.0/schemas";
    GTK_USE_PORTAL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    NIXOS_OZONE_WL = "1";
    NIXOS_XDG_OPEN_USE_PORTAL = "1";
    POLKIT_AUTH_AGENT = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
    SDL_VIDEODRIVER = "wayland";
    WLR_NO_HARDWARE_CURSORS = "1";
    WLR_RENDERER = "vulkan";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
  };
}
