{...}: {
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.gdm.enableGnomeKeyring = true;
  programs.seahorse.enable = true;

  security.polkit.enable = true;

  services.fprintd.enable = true;

  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
    fprintAuth = true;
  };

  programs.wireshark.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
}
