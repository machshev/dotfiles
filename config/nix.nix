{...}: {
  nixpkgs.config.allowUnfree = true;

  # Enable flakes + new nix command
  nix.settings.experimental-features = ["nix-command" "flakes"];

  nix.settings.substituters = [
    "https://cache.nixos.org/"
    "https://nix-cache.lowrisc.org/public/"
  ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # nix.settings.auto-optimise-store = true;
  nix.optimise = {
    automatic = true;
    dates = ["weekly"];
  };
}
