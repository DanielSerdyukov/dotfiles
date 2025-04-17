if [[ -f /opt/homebrew/bin/brew ]]; then
    eval $(/opt/homebrew/bin/brew shellenv)
fi

if [[ -f $HOME/.lessfilter ]]; then
    export LESSOPEN='|~/.lessfilter %s'
fi

if [[ -f $HOME/.cargo/env ]]; then
    . "$HOME/.cargo/env"
fi