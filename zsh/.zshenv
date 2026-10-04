# ~/.zshenv
# Sourced for all zsh invocations (login, interactive, scripts)
# Use for environment variables, PATH, and non-interactive settings

# --- Locale ---
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# --- XDG Directories ---
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_STATE_HOME="${HOME}/.local/state"

typeset -U path
path=("$HOME/.local/bin" $path)

if [[ -d /opt/homebrew/bin ]]; then
  path=(/opt/homebrew/bin $path)
elif [[ -d /usr/local/bin ]]; then
  path=(/usr/local/bin $path)
fi
typeset -U path

# --- Default Editor ---
if command -v nvim &>/dev/null; then
    export EDITOR="nvim"
    export VISUAL="nvim"
else
    export EDITOR="vi"
    export VISUAL="vi"
fi

# # --- PATH Configuration ---
[[ -f "${HOME}/.lessfilter" ]] && export LESSOPEN="|${HOME}/.lessfilter %s"
