# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

export EDITOR=nvim

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignorespace,ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=50000
HISTFILESIZE=$HISTSIZE
HISTIGNORE="clear:bg:fg:cd:cd -:cd ..:exit:date:w:s:gs:ls:l:ll:lla"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
if [ -x /usr/bin/lesspipe ]; then
    eval "$(SHELL=/bin/sh lesspipe)"
fi

export CLICOLOR=1
export LSCOLORS=exfxcxdxbxegedabagacad

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color | *-256color) color_prompt=yes ;;
esac

# Source the git bash completion file
if [ -f ~/.git-completion.bash ]; then
    source ~/.git-completion.bash
    source ~/.git-prompt.sh
fi

export PROMPT_COMMAND="history -a"

# enable color support of ls
if [ -x /usr/bin/dircolors ]; then
    if [ -r "$HOME/.dircolors" ]; then
        eval "$(dircolors -b ~/.dircolors)"
    else
        eval "$(dircolors -b)"
    fi
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        source /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        source /etc/bash_completion
    fi
fi

alias SS="sudo env HOME=\"$HOME\" bash"
alias watch="watch -c"

alias tmux="TERM=screen-256color tmux -2"

# Emacs
alias emacsserver="emacs --bg-daemon=server; psgrep emacs"
alias emacs-profile="emacs -Q -l ${HOME}/emacs/profile.el -f profile-dotemacs"
alias edit="\${EDITOR}"

# TODO: Replicate this
# git config
#git config --global core.pager "less --LONG-PROMPT --tabs=3 --quit-at-eof --quit-if-one-screen --tilde --jump-target=3 --ignore-case --status-column"
git config --global core.pager "delta"
git config --global interactive.diffFilter "delta --color-only"
git config --global delta.features "side-by-side line-numbers decorations"
git config --global delta.whitespace-error-style "22 reverse"
git config --global sequence.editor "interactive-rebase-tool"

function is_linux() {
    uname | grep -iq linux
}

function is_wsl() {
    uname -a | grep -iq microsoft
}

# Persist ssh session across shells in WSL
if is_wsl && keychain --quiet; then
    eval "$(keychain --quiet --eval id_rsa)"
fi

if is_linux; then
    alias ls='ls -A --color=auto --group-directories-first --time-style=long-iso --human-readable -v'
    alias ll='ls -l'
fi

# grep shorthands
alias hg='history | grep'
alias egrep='env | grep'
unset GREP_OPTIONS

# creates a temp dir and cds into it
alias td='pushd $(mktemp -d)'

if is_linux; then
    if is_wsl; then
        alias o='wslview'
    else
        alias o='xdg-open'
    fi
fi

# pylint
alias pytestd='pytest --pdb --pdbcls=IPython.terminal.debugger:TerminalPdb -s'

# Quick way to serve files in HTTP from the local dir
alias webs-py='python3 -m http.server'
alias webs='basic-http-server -x'

alias cpv='rsync -ah --info=progress2'

alias logs="find /var/log -type f -exec file {} \; | grep 'text' | cut -d' ' -f1 | sed -e's/:$//g' | grep -v '[0-9]$' | xargs tail -f"

# Kubernetes
alias kc="kubectl"

# PlatformIO
alias pio-shell="source ~/.platformio/penv/bin/activate"

# Cadence
alias cl="lmstat -a"
alias clm="lmstat -a | grep --color=never \"Users of|\$(whoami)\" | grep -B1 \$(whoami)"

# python
alias pvea=". ./.venv/bin/activate"
alias a="nix develop \$DEV_FLAKE"

# Go
alias gta="go test ./..."

# Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] &&
    . /usr/share/bash-completion/bash_completion

if [ -f "$HOME/.iterm2_shell_integration.bash" ]; then
    source "$HOME/.iterm2_shell_integration.bash"
fi

# shellcheck disable=SC1090
#source "${HOME}/common_functions"

# shellcheck disable=SC1090
source "${HOME}/.local/share/completion/git-diff-branches-completion.bash"
# shellcheck disable=SC1090
source "${HOME}/.local/share/completion/complete_alias"

complete -F _complete_alias ga
complete -F _complete_alias gb
complete -F _complete_alias gbs
complete -F _complete_alias gc
complete -F _complete_alias gcnv
complete -F _complete_alias gca
complete -F _complete_alias gcanv
complete -F _complete_alias gcane
complete -F _complete_alias gco
complete -F _complete_alias gpu
complete -F _complete_alias gP
complete -F _complete_alias gd
complete -F _complete_alias gdl
complete -F _complete_alias gds
complete -F _complete_alias gg
complete -F _complete_alias gk
complete -F _complete_alias gl
complete -F _complete_alias glog
complete -F _complete_alias gm
complete -F _complete_alias gp
complete -F _complete_alias gsta
complete -F _complete_alias gstcl
complete -F _complete_alias gstd
complete -F _complete_alias gstl
complete -F _complete_alias gsts
complete -F _complete_alias gr
complete -F _complete_alias gri
complete -F _complete_alias gra
complete -F _complete_alias grc
complete -F _complete_alias pylint
complete -F _complete_alias gb-delete-remote
complete -F _complete_alias gb-delete-local

# cd alias
if command -v zoxide >/dev/null; then
    eval "$(zoxide init bash)"
    alias cd='z'
fi

# rust powered utils
if command -v eza >/dev/null; then
    alias ls="eza -g"
    alias x='eza'
    alias tree='eza --tree'
fi

if command -v hyperfine >/dev/null; then
    alias bench='hyperfine'
    alias top='btm'
    alias htop='btm'
fi

if command -v dust >/dev/null; then alias du='dust'; fi
if command -v bat >/dev/null; then alias cat='bat'; fi
if command -v rg >/dev/null; then alias grep='rg -i'; fi
if command -v tokei >/dev/null; then alias cloc='tokei'; fi
if command -v procs >/dev/null; then alias ps='procs'; fi

function reload() {
    export OLD_PS1="$PS1"
    # shellcheck disable=SC1090
    source "${HOME}/.bashrc"
    export PS1="$OLD_PS1"
}

# export PS1="[\t] \h:\W\\$ "

function gb-rename-local-and-origin-remote() {
    if [[ -z "$1" ]]; then
        echo "New branch name is missing"
        return 1
    fi

    CURRENT_BRANCH="$(gbc)"
    NEW_BRANCH="${1}"

    heading "Renaming current branch [${CURRENT_BRANCH}] to [${NEW_BRANCH}]"

    echo "Renaming local branch..."
    git branch -m "${NEW_BRANCH}" || exit 1
    echo "Rename the remote branch..."
    git push origin ":${CURRENT_BRANCH}" "${NEW_BRANCH}" || exit 1
    echo "Reset the upstream tracking branch"
    git push origin -u "${NEW_BRANCH}" || exit 1
    echo
    echo "Branch successfully renamed"
}

function rsed() {
    while IFS= read -r -d '' file; do
        sed -e "${2}" "${file}" | diff -u "${file}" - | colordiff
    done < <(find . -type f -name "${1}" -print0)
}

function rsed-do() {
    while IFS= read -r -d '' file; do
        sed -i "${2}" "${file}"
    done < <(find . -type f -name "${1}" -print0)
}

function edit-src() {
    edit "$(which "${1}")"
}

function debug-python() {
    local cmd="${1}"
    shift
    if command -v ipdb >/dev/null; then export PYTHONBREAKPOINT="ipdb.set_trace"; fi
    if command -v ipdb3 >/dev/null; then export PYTHONBREAKPOINT="ipdb.set_trace"; fi
    ipython --pdb "$(which "${cmd}")" -- "$@"
}

function stats-line() {
    echo -e "\e[1m${1}:\e[21m \e[${3}m${2}\e[0m"
}

function where() {
    stats-line "VEnv" "${VIRTUAL_ENV}" 31
    stats-line "Dir" "${PWD}" 32
    stats-line "pushd" "$(dirs)" 34

    stats-line "git branch"
    git branch

    stats-line "git changes"
    git status -s
}

function weather() {
    local location=$1
    if [ -z "${location}" ]; then
        location="Fordham"
    fi
    curl "v2.wttr.in/${location}"
}

function use-rclone-here() {
    RCLONE_CONFIG="$PWD/rclone.conf"
    export RCLONE_CONFIG

    rclone config file
}

# SSH
SSH_ENV=$HOME/.ssh/environment

function start_agent {
    echo "Initialising new SSH agent..."
    ssh-agent | sed 's/^echo/#echo/' >"${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    source "${SSH_ENV}" >/dev/null
    ssh-add
}

# Source SSH settings, if applicable

[[ $TERM == "tramp" ]] && unsetopt zle && PS1='$ ' && return

# configure tmux
if [ -f ~/.tmux/tmux_bash_completion ]; then
    source "$HOME/.tmux/tmux_bash_completion"
fi

# opam configuration
if [ -f "$HOME/.opam/opam-init/init.sh" ]; then
    source "$HOME/.opam/opam-init/init.sh" >/dev/null 2>/dev/null
fi

# configure fzf
if command -v fzf >/dev/null; then
    export FZF_COMPLETION_TRIGGER='~~'
    export FZF_COMPLETION_OPTS='--border --info=inline'
    export FZF_DEFAULT_COMMAND="rg --files --hidden"
    export FZF_ALT_C_COMMAND="fd --type d"

    _fzf_compgen_path() {
        rg --files --hidden
    }

    _fzf_compgen_dir() {
        fd --type d --hidden --folow --exclude ".git" . "$1"
    }

    # _fzf_setup_completion path npm
fi

eval "$(starship init bash)"
eval "$(direnv hook bash)"

if [ -f "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
fi
