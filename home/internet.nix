{
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    firefox-wayland
  ];
}
