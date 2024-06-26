{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    hyperfine
    hyprland-protocols
    hyprpaper
    hyprpicker
    brightnessctl
    playerctl
    blueman
    dunst
    dolphin
    wofi
    xclip
    swayidle
    swaylock
    waybar
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    xdg-utils
    ydotool
    wl-clipboard
    gnome3.nautilus
    pavucontrol
  ];
}
