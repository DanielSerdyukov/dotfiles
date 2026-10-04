# --- FZF Configuration ---
if command -v fzf &>/dev/null; then
    export FZF_DEFAULT_OPTS="--height=40% --layout=reverse --info=inline --border --pointer ▶"
    export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --exclude .git'
    export FZF_COMPLETION_PATH_OPTS="--walker file,dir,follow,hidden"
    export FZF_COMPLETION_DIR_OPTS="--walker dir,follow"

    # Load fzf shell integration
    eval "$(fzf --zsh)"

    _fzf_compgen_path() {
        fd --hidden --follow --exclude ".git" . "$1"
    }

    _fzf_compgen_dir() {
        fd --type d --hidden --follow --exclude ".git" . "$1"
    }

    zinit light Aloxaf/fzf-tab

    zstyle ':completion:*' menu no
    zstyle ':fzf-tab:*' fzf-flags --height=40% --layout=reverse --info=inline --border --pointer ▶
    zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -a --color=always --icons=always --git --group-directories-first --tree --git-ignore $realpath'
    zstyle ':fzf-tab:complete:brew-(install|uninstall|search|info):*-argument-rest' fzf-preview 'HOMEBREW_COLOR=1 brew info $word'
    zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview 'ps -p $word -o time,%cpu,%mem,command -w'
    zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'
    zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview 'git diff $word | delta'
    zstyle ':fzf-tab:complete:git-(checkout|log):*' fzf-preview 'git log --color=always $word'
    zstyle ':fzf-tab:complete:*:*' fzf-preview 'less ${(Q)realpath}'
    zstyle ':fzf-tab:*' switch-group '<' '>'
fi
