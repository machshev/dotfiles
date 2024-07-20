{pkgs, ...}: {
  home.packages = with pkgs; [
    # Common
    gnumake
    git
    typos-lsp
    gh
    direnv
    tokei

    # Asm
    asm-lsp

    # Lua
    lua-language-server

    # Rust
    rustc
    rust-analyzer
    cargo

    # Go
    go
    buf
    buf-language-server

    # Zig
    zig
    zls

    # C
    gcc
    #clang
    maim
    conky

    # Python
    python312Packages.python-lsp-server
    python312Packages.pylsp-mypy
    python312Packages.pylsp-rope
    ruff

    # Nix
    nil
    nixd

    # PHP
    php
    phpactor

    # Node
    nodejs

    # Shell
    shellcheck
    nodePackages.bash-language-server

    # ansible
    ansible-language-server
    ansible-lint

    # Docker
    docker-compose

    # libvirt
    virt-manager

    # terraform
    terraform
    terraform-ls
    google-cloud-sdk
    yamllint
    yaml-language-server

    # eda
    usbutils
    sigrok-cli
    sigrok-firmware-fx2lafw
    pulseview
    picotool

    binwalk

    # Programmers
    #segger-ozone
    openssl.dev

    # Misc [old]
    v4l-utils
    vlc
  ];
}
