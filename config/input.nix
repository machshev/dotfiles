{
  config,
  pkgs,
  inputs,
  ...
}: {
  # touchpad support
  services.libinput.enable = true;

  services.xserver.xkb.layout = "us,gb,il";
  services.xserver.xkb.variant = "";
}
