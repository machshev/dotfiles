{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    # TODO: pull out common config with hyprland
    brightnessctl
    playerctl
    blueman
    nitrogen
    dunst
    dolphin
    wofi
    xclip
    swayidle
    swaylock
    waybar
    xdg-desktop-portal-gtk
    xdg-desktop-portal-wlr
    xdg-utils
    ydotool
    wl-clipboard
    nautilus
    pavucontrol

    # TODO: Split these out
    nwg-displays
    nwg-bar
    #nwg-panel
  ];
}
