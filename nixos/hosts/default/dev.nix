
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
    ];
}
