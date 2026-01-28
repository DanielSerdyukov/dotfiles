# ~/.zshrc

# ============================================================================
# History Configuration
# ============================================================================
HISTFILE="$HOME/.zhistory"
HISTSIZE=10000
SAVEHIST=10000

setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits
setopt SHARE_HISTORY             # Share history between all sessions
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry
setopt HIST_VERIFY               # Don't execute immediately upon history expansion

# ============================================================================
# Zinit Plugin Manager
# ============================================================================
if [[ ! -f "${ZINIT_HOME}/zinit.git/zinit.zsh" ]]; then
    command mkdir -p "${ZINIT_HOME}" && command chmod g-rwX "${ZINIT_HOME}"
    command git clone https://github.com/zdharma-continuum/zinit "${ZINIT_HOME}/zinit.git"
fi
source "${ZINIT_HOME}/zinit.git/zinit.zsh"

# ============================================================================
# Completion System
# ============================================================================
autoload -Uz compinit
compinit

zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"
zstyle ':completion:*' complete true
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# ============================================================================
# FZF Configuration
# ============================================================================
# Initialize fzf key bindings and completion
if command -v fzf &>/dev/null; then
    FZF_DEFAULT_OPTS="--height=40% --layout=reverse --info=inline --border --pointer ▶"
    FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --exclude .git'
    FZF_COMPLETION_PATH_OPTS="--walker file,dir,follow,hidden"
    FZF_COMPLETION_DIR_OPTS="--walker dir,follow"
    
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
    zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'
    zstyle ':fzf-tab:complete:*:*' fzf-preview 'less ${(Q)realpath}'
fi

# ============================================================================
# Zinit Plugins
# ============================================================================
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions

# Reload completions after loading plugins
zinit cdreplay -q

# ============================================================================
# FZF-Tab Configuration
# ============================================================================
# Disable sort when completing `git checkout`
# zstyle ':completion:*:git-checkout:*' sort false

# # Set descriptions format to enable group support
# zstyle ':completion:*:descriptions' format '[%d]'

# # Switch group using `<` and `>`
# zstyle ':fzf-tab:*' switch-group '<' '>'

# # Use tmux popup for fzf-tab (if in tmux)
# zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup

# ============================================================================
# Directory Navigation
# ============================================================================
setopt AUTO_CD                   # Go to folder path without using cd
setopt AUTO_PUSHD                # Push the old directory onto the stack on cd
setopt PUSHD_IGNORE_DUPS         # Do not store duplicates in the stack
setopt PUSHD_SILENT              # Do not print the directory stack after pushd or popd

# ============================================================================
# General Options
# ============================================================================
setopt INTERACTIVE_COMMENTS      # Allow comments in interactive shell
setopt MULTIOS                   # Perform implicit tees or cats when multiple redirections are attempted
setopt PROMPT_SUBST              # Enable parameter expansion, command substitution, and arithmetic expansion in prompts
setopt NO_BEEP                   # Don't beep on errors

# ============================================================================
# Key Bindings
# ============================================================================
bindkey -e                       # Use emacs key bindings

# Navigate by word
bindkey '^[[1;5C' forward-word   # Ctrl+Right
bindkey '^[[1;5D' backward-word  # Ctrl+Left

# ============================================================================
# Aliases
# ============================================================================
# Directory listing (eza if available, otherwise fallback to ls)
if command -v eza &>/dev/null; then
    alias ls='eza --color --icons --group-directories-first'
    alias ll='eza -l --color --icons --git --group-directories-first'
    alias lla='eza -la --color --icons --git --group-directories-first'
    alias lt='eza -la --color --icons --git --group-directories-first --tree --git-ignore'
    alias tree='eza -la --color --icons --git --group-directories-first --tree --git-ignore'
else
    alias ls='ls -G'
    alias ll='ls -lh'
    alias lla='ls -lAh'
fi

# Directory navigation
alias ..='cd ..'

# Safety nets
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Utilities
alias grep='grep --color=auto'
alias df='df -h'
alias du='du -h'
alias mkdir='mkdir -pv'

# ============================================================================
# Prompt (Starship)
# ============================================================================
if command -v starship &>/dev/null; then
    eval "$(starship init zsh)"
else
    # Fallback prompt if starship is not installed
    PROMPT='%F{green}%n@%m%f:%F{blue}%~%f%# '
fi

# ============================================================================
# Zoxide (Smart Directory Navigation)
# ============================================================================
if command -v zoxide &>/dev/null; then
    eval "$(zoxide init zsh --cmd cd)"
fi
