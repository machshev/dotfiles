# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ]; then
  export PATH="$PATH:$HOME/.local/bin"
fi

# Add local scripts folder into PATH
if [ -d "$HOME/scripts" ]; then
  export PATH="$PATH:$HOME/scripts/"
fi

# Add Android SDK related PATH
if [ -d "$HOME/Android/Sdk" ]; then
  export ANDROID_SDK_ROOT="$HOME/Android/Sdk"
elif [ -d "$HOME/Library/Android/sdk" ]; then
  export ANDROID_SDK_ROOT="$HOME/Library/Android/Sdk"
fi

if [ -d "$ANDROID_SDK_ROOT" ]; then
  export ANDROID_HOME="$ANDROID_SDK_ROOT"
  export PATH="$ANDROID_SDK_ROOT/emulator:$PATH"
  export PATH="$ANDROID_SDK_ROOT/tools:$PATH"
  export PATH="$ANDROID_SDK_ROOT/tools/bin:$PATH"
  export PATH="$ANDROID_SDK_ROOT/platform-tools:$PATH"
fi

# Add Android SDK related PATH
if [ -d "$HOME/android-studio/bin" ]; then
  export PATH="$PATH:$HOME/android-studio/bin"
fi

if [ -x "/usr/lib/jvm/java-11-openjdk-amd64" ]; then
  export JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"
fi

# Add n related variables
export N_PREFIX="$HOME/.n"

if [ -d "$N_PREFIX" ]; then
  export PATH="$N_PREFIX/bin:$PATH"
fi

# Add npm related PATH
NPM_PACKAGES="$HOME/.npm-packages"

if [ -d "$NPM_PACKAGES" ]; then
  export PATH="$PATH:$NPM_PACKAGES/bin"
  export MANPATH="$MANPATH:$NPM_PACKAGES/share/man"
fi

# Add Go related PATH
export GOPATH="$HOME/go"

if [ -d "$GOPATH" ]; then
  export PATH="$PATH:$GOPATH/bin"
fi

if [ -d "/usr/local/go/bin" ]; then
  export PATH="$PATH:/usr/local/go/bin"
fi

# Add Rust related PATH
if [ -d "$HOME/.cargo/env" ]; then
  export PATH="$PATH:$HOME/.cargo/env"
fi

# Add Homebrew
if [ -d "/opt/homebrew/bin" ]; then
  export PATH="$PATH:/opt/homebrew/bin"
fi

# opam configuration
if [ -f $HOME/.opam/opam-init/init.sh &&]; then
  . "$HOME/.opam/opam-init/init.sh" > /dev/null 2> /dev/null
fi

# Add pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"

if [ -f ~/.iterm2_shell_integration.bash ]; then
    . ~/.iterm2_shell_integration.bash
fi

# shellcheck disable=SC1090
#source "${HOME}/common_functions"

export TZ=Europe/London

if command -v nvim > /dev/null ; then
    export EDITOR="nvim"
    export PYTHON_EDITOR="nvim"
else
    export EDITOR="emacs --load=${CONFIG_HOME}/emacs/simple-init.el -q -nw"
    export PYTHON_EDITOR="emacs --load=${CONFIG_HOME}/emacs/simple-init.el -q"
fi
export ALTERNATE_EDITOR="vim"


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

# Add default less options
# -F to quit automatically if the file is shorter than the screen
# -X to not clear the screen after quitting
# -R to show only color escape sequences in raw form
# -M to show a more verbose prompt
export LESS='-S -F -i -J -M -R -W -x4 -X -z-4'
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

if ! command -v docker > /dev/null ; then
    alias docker=podman
fi

# Set the Less input preprocessor.
if command -v lesspipe.sh > /dev/null ; then
    export LESSOPEN='|lesspipe.sh %s'
fi

if command -v pygmentize > /dev/null ; then
    export LESSCOLORIZER='pygmentize -f 256'
fi

# Give snaps higher precedent
[ -d "/snap" ] && export PATH=/snap/bin:$PATH

export PAGER="less"
export BAT_PAGER="less"
export BAT_CONFIG_PATH="${CONFIG_HOME}/bat.conf"

export IPDB_CONTEXT_SIZE=10
#export PYTEST_ADDOPTS='--pdb --pdbcls=IPython.terminal.debugger:Pdb'

alias ss="sudo env HOME=\"$HOME\" bash"
alias watch="watch -c"

alias tmux="TERM=screen-256color tmux -2"

# Emacs
alias emacsserver="emacs --bg-daemon=server; psgrep emacs"
alias emacs-profile="emacs -Q -l ${CONFIG_HOME}/emacs/profile.el -f profile-dotemacs"
alias edit="\${EDITOR}"

# git config
#git config --global core.pager "less --LONG-PROMPT --tabs=3 --quit-at-eof --quit-if-one-screen --tilde --jump-target=3 --ignore-case --status-column"
git config --global core.pager "delta"
git config --global interactive.diffFilter "delta --color-only"
git config --global delta.features "side-by-side line-numbers decorations"
git config --global delta.whitespace-error-style "22 reverse"
git config --global sequence.editor "interactive-rebase-tool"


# git shorthands
alias gme="git config user.name"
alias gou="git config remote.origin.url"

alias gs="git status -b --show-stash -M --ahead-behind"
alias ga="git add"

alias gb='git branch'
alias gbc='git rev-parse --abbrev-ref HEAD'
alias gb-list-merged="git for-each-ref --format='%(creatordate:short) %(authorname) %(refname:short)' -s --sort=authorname --merged origin/master"
alias gb-list-not-merged="git for-each-ref --format='%(creatordate:short) %(authorname) %(refname:short)' -s --sort=authorname --no-merged origin/master"
alias gblm="gb-list-merged"
alias gblnm="gb-list-not-merged"
alias gbs='git show-branch'
alias gbdm='git branch --merged | grep -v "(^\*|master|main|dev)" | xargs git branch -d'

alias gA="clean; git add -A; gs"
alias gu="clean; git add -u; gs"

alias gcv="clean; git commit -m --verify"
alias gc="clean; git commit -m"
alias gca="clean; git commit --amend"
alias gcnv="clean; git commit --no-verify -m"
alias gcanv="clean; git commit --no-verify --amend"
alias gcane="gca --no-edit"

alias gco='git checkout'
alias gpu="git pull --rebase"
alias gp="git push --follow-tags"
alias gP="git push -f"

alias gd="git diff"
alias gdl="gd HEAD~1"
alias gds="git diff --staged"
alias gdt="git difftool"
alias gdtl="gdtool HEAD~1"
alias gdts="git difftool --staged"

alias gg='git grep'
alias gk='gitk --all'
alias gl="glog -10"
alias glog='git log --pretty=format:"%C(yellow)%h %C(cyan)%<(24)%ad %Cgreen%an%C(auto)%d%Creset: %s" --date=local'
alias gm="git merge --ff-only --no-verify"
alias gmt="git mergetool"

alias gsta="git stash apply"
alias gstcl="git stash clear"
alias gstd="git stash drop"
alias gstl='git stash list --pretty=format:"%C(red)%<(10)%gd %C(yellow)%h %C(cyan)%<(13)%cr %Cgreen%an%C(auto)%d%Creset: %s"'
alias gsts="git stash show"

alias gr="git rebase"
alias gri="git rebase -i"
alias gra="gr --abort"
alias grc="gr --continue"

alias grp="git remote prune origin"

alias gb-delete-remote="git push origin --delete"
alias gb-delete-local="git branch -d"

alias dirs='dirs -p -v'
alias s='echo -e "\e[33m${PWD}\e[0m"; ls'
alias ..="cd ..; s"
alias ...="cd ../..; s"
alias ....="cd ../../..; s"
alias .....="cd ../../../..; s"
alias ......="cd ../../../../..; s"
alias .......="cd ../../../../../..; s"
alias ........="cd ../../../../../../..; s"
alias .........="cd ../../../../../../../..; s"
alias ..........="cd ../../../../../../../../..; s"
alias ...........="cd ../../../../../../../../../..; s"

alias cdve='pushd ${VIRTUAL_ENV}; s'
alias cdch='pushd ${CONFIG_HOME}; s'
alias cdgt='pushd `git rev-parse --show-toplevel`; s'

alias r='ranger'

if is_linux; then
  alias ls='ls -A --color=auto --group-directories-first --time-style=long-iso --human-readable -v'
  alias ll='ls -l'
fi

# ls shorthands
alias l="ls"
alias ll="ls -lh"
alias la="ls -a"
alias lla="ls -lha"
alias left='ls -t -1'

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
alias pylint='pylint --output-format=colorized --rcfile=~/.pylintrc'
alias allpep8="find . -name '*.py' -exec autopep8 -iaaaaaaaa {} \;"

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
alias clm="lmstat -a | grep --color=never \"Users of|$(whoami)\" | grep -B1 $(whoami)"

# python
alias pvea=". ./.venv/bin/activate"

# Go
alias gta="go test ./..."

# SSH
SSH_ENV=$HOME/.ssh/environment

# Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion

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
if command -v zoxide > /dev/null ; then
    eval "$(zoxide init bash)"
    alias cd='z'
fi

# rust powered utils
if command -v exa > /dev/null ; then
    alias ls="exa -g"
    alias x='exa'
    alias tree='exa --tree'
fi

if command -v hyperfine > /dev/null ; then
    alias bench='hyperfine'
    alias top='btm'
    alias htop='btm'
fi

if command -v dust > /dev/null ; then alias du='dust'; fi
if command -v bat > /dev/null ; then alias cat='bat'; fi
if command -v rg > /dev/null ; then alias grep='rg -i'; fi
if command -v tokei > /dev/null ; then alias cloc='tokei'; fi
if command -v procs > /dev/null ; then alias ps='procs'; fi


function reload() {
  export OLD_PS1="$PS1"
  # shellcheck disable=SC1090
  source "${HOME}/.bashrc"
  export PS1="$OLD_PS1"
}

# export PS1="[\t] \h:\W\\$ "


function gb-rename-local-and-origin-remote() {
    if [[ -z "$1" ]] ; then
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
    echo "Branch sucessfully renamed"
}


function rsed () {
    while IFS= read -r -d '' file; do
        sed -e "${2}" "${file}" | diff -u "${file}" - | colordiff
    done < <(find . -type f -name "${1}" -print0)
}

function rsed-do () {
    while IFS= read -r -d '' file; do
        sed -i "${2}" "${file}"
    done < <(find . -type f -name "${1}" -print0)
}

function edit-src () {
    edit `which "${1}"`
}

function debug-python () {
    local cmd="${1}"
    shift
    ipython --pdb `which "${cmd}"` -- $@
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
    if [ -z "${location}" ] ; then
        location="Fordham"
    fi
    curl "v2.wttr.in/${location}"
}

function use-rclone-here() {
    RCLONE_CONFIG="$PWD/rclone.conf"
    export RCLONE_CONFIG

    rclone config file
}

function start_agent {
     echo "Initialising new SSH agent..."
     /usr/bin/ssh-agent | sed 's/^echo/#echo/' > ${SSH_ENV}
     echo succeeded
     chmod 600 ${SSH_ENV}
     . ${SSH_ENV} > /dev/null
     /usr/bin/ssh-add;
}

# Source SSH settings, if applicable

[[ $TERM == "tramp" ]] && unsetopt zle && PS1='$ ' && return

if [[ $- == *i* ]]; then
  if [ -f "${SSH_ENV}" ]; then
    . ${SSH_ENV} > /dev/null
    ps ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
  else
       start_agent;
  fi
fi


# if running bash
if [ -n "$BASH_VERSION" ]; then
  # include .bashrc if it exists
  if [ -f "$HOME/.bashrc" ]; then
    source "$HOME/.bashrc"
  fi
fi
