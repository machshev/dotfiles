
{config, pkgs, ...}:

{
    home.packages = with pkgs; [
        gnumake
        git
        asm-lsp
        docker-compose
        go
        cargo
        nodejs
        php
        phpactor
        rustc
        rust-analyzer
        python312Packages.python-lsp-server
        python312Packages.pylsp-mypy
        python312Packages.pylsp-rope
        lua-language-server
        nixd
        ruff
        shellcheck
        buf
        buf-language-server
    ];
}
