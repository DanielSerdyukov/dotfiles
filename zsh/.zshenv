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

# --- Zsh Configuration ---
export ZDOTDIR="${HOME}"                    # Zsh config directory
export ZINIT_HOME="${XDG_DATA_HOME}/zinit"  # Zinit plugin manager home

# --- Default Editor ---
if command -v nvim &>/dev/null; then
    export EDITOR="nvim"
    export VISUAL="nvim"
else
    export EDITOR="vi"
    export VISUAL="vi"
fi

# --- PATH Configuration ---
[[ -d "${HOME}/.local/bin" ]] && export PATH="${HOME}/.local/bin:${PATH}"
[[ -f "${HOME}/.lessfilter" ]] && export LESSOPEN="|${HOME}/.lessfilter %s"
export LESS="-R"  # pass ANSI colors (e.g. from lessfilter) through

# --- Terminfo ---
export TERMINFO="$HOME/.terminfo"
export TERMINFO_DIRS="$HOME/.terminfo:/usr/share/terminfo"
