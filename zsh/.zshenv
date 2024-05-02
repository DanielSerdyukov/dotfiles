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
