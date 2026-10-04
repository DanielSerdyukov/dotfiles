# --- Zinit Plugin Manager ---
export ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit"
if [[ ! -f "${ZINIT_HOME}/zinit.git/zinit.zsh" ]]; then
    command mkdir -p "${ZINIT_HOME}" && command chmod g-rwX "${ZINIT_HOME}"
    command git clone https://github.com/zdharma-continuum/zinit "${ZINIT_HOME}/zinit.git"
fi
if [[ -f "${ZINIT_HOME}/zinit.git/zinit.zsh" ]]; then
    source "${ZINIT_HOME}/zinit.git/zinit.zsh"
fi
