{pkgs, ...}: {
  home.packages = with pkgs; [
    nitrogen
    mako
  ];
}
