{pkgs, ...}: {
  home.packages = with pkgs; [
    hyperfine
    hyprland-protocols
    hyprpaper
    hyprpicker
    xdg-desktop-portal-hyprland
  ];
}
