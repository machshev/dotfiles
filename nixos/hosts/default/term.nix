{config, pkgs, ...}:

{
    home.packages = with pkgs; [
        alacritty
        bandwhich
        bat
        bemenu
        bingrep
        bottom
        broot
        delta
        dutree
        eza
        fd
        feh
        fzf
        gitui
        grex
        grim
        mosh
        neovim
        procs
        ranger
        ripgrep
        screen
        skim
        slurp
        starship
        stow
        tealdeer
        tmux
        unzip
        wget
        zoxide
    ];

}
