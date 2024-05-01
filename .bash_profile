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

# Add pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"

export TZ=Europe/London

if command -v nvim >/dev/null; then
	export EDITOR="nvim"
	export PYTHON_EDITOR="nvim"
else
	export EDITOR="emacs --load=${CONFIG_HOME}/emacs/simple-init.el -q -nw"
	export PYTHON_EDITOR="emacs --load=${CONFIG_HOME}/emacs/simple-init.el -q"
fi
export ALTERNATE_EDITOR="vi"

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

if ! command -v docker >/dev/null; then
	alias docker=podman
fi

# Set the Less input preprocessor.
if command -v lesspipe.sh >/dev/null; then
	export LESSOPEN='|lesspipe.sh %s'
fi

if command -v pygmentize >/dev/null; then
	export LESSCOLORIZER='pygmentize -f 256'
fi

# Give snaps higher precedent
[ -d "/snap" ] && export PATH=/snap/bin:$PATH

export PAGER="less"
export BAT_PAGER="less"
export BAT_CONFIG_PATH="${CONFIG_HOME}/bat.conf"

export IPDB_CONTEXT_SIZE=10
#export PYTEST_ADDOPTS='--pdb --pdbcls=IPython.terminal.debugger:Pdb'

# if running bash
if [ -n "$BASH_VERSION" ]; then
	# include .bashrc if it exists
	if [ -f "$HOME/.bashrc" ]; then
		source "$HOME/.bashrc"
	fi
fi
. "$HOME/.cargo/env"
