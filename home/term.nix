{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    alacritty
    neofetch
    nnn
    screen
    tmux
    starship

    # system
    bottom
    btop
    iotop
    iftop
    procs
    fd
    dysk
    killall
    strace
    ltrace
    lsof
    sysstat
    lm_sensors
    ethtool
    pciutils
    usbutils
    gparted

    # installing and syncing
    stow
    rclone

    # file searching and manipulation
    fzf
    jq
    jless
    yq-go
    bat
    delta
    ripgrep
    eza
    zoxide

    # ssh and remote
    mosh
    wget
    curl
    wayvnc

    # editors and viewing
    neovim

    # git
    gitui

    # misc
    bemenu
    bingrep
    broot
    dutree
    feh
    grex
    grim
    ranger
    skim
    slurp

    # docs
    tealdeer

    # archives
    unzip
    xz
    p7zip
    zip

    # networking
    mtr
    bandwhich
    iperf3
    dnsutils
    ldns
    aria2
    socat
    nmap
    ipcalc
  ];
}
