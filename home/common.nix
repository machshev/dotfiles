{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./dev.nix
    ./desktop-common.nix
    ./hyperland.nix
    ./internet.nix
    ./office.nix
    ./sway.nix
    ./term.nix
  ];

  home.stateVersion = "24.05"; # Please read the comment before changing.

  nixpkgs.config = lib.mkForce {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    gnome.cheese
    gimp
    inkscape
    blender
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
