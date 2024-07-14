{pkgs, ...}: {
  home.packages = with pkgs; [
    gnumake
    git
    asm-lsp
    docker-compose
    go
    cargo
    nodejs
    php
    # phpactor
    rustc
    rust-analyzer
    python312Packages.python-lsp-server
    python312Packages.pylsp-mypy
    python312Packages.pylsp-rope
    lua-language-server
    typos-lsp
    nixd
    ruff
    nil
    shellcheck
    buf
    buf-language-server
    terraform
    terraform-ls
    google-cloud-sdk
  ];
}
