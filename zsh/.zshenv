# editor
if [ "$(command -v nvim)" ]; then
    export EDITOR="nvim"
    export VISUAL="nvim"
fi

# XDG
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache

# zsh
export ZDATADIR="$XDG_DATA_HOME/zsh"

if [[ -f /opt/homebrew/bin/brew ]]; then
    eval $(/opt/homebrew/bin/brew shellenv)
fi

if [[ -f $HOME/.lessfilter ]]; then
    export LESSOPEN='|~/.lessfilter %s'
fi

if [[ -f $HOME/.cargo/env ]]; then
    . "$HOME/.cargo/env"
fi