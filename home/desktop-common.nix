{pkgs, ...}: {
  home.packages = with pkgs; [
    blueman
    brightnessctl
    dunst
    gnome.nautilus
    pavucontrol
    playerctl
    swayidle
    swaylock
    tailscale-systray
    waybar
    wl-clipboard
    wofi
    xclip
    xdg-desktop-portal-gtk
    xdg-desktop-portal-gtk
    xdg-desktop-portal-wlr
    xdg-utils
    ydotool

    bitwarden-desktop
    bitwarden-cli
    bitwarden-menu
    goldwarden

    # nwg-shell
    nwg-displays
    nwg-bar
    #nwg-panel
  ];
}
