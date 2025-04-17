HISTFILE=$HOME/.zhistory
HISTSIZE=10000
SAVEHIST=10000

setopt append_history           # allow multiple sessions to append to one history
setopt hist_expire_dups_first   # expire duplicates first when trimming history
setopt hist_find_no_dups        # When searching history, don't repeat
setopt hist_ignore_dups         # ignore duplicate entries of previous events
setopt hist_ignore_space        # prefix command with a space to skip it's recording
setopt hist_reduce_blanks       # Remove extra blanks from each command added to history
setopt hist_verify              # Don't execute immediately upon history expansion
setopt inc_append_history       # Write to history file immediately, not when shell quits
setopt share_history            # Share history among all sessions

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

#autoload -Uz _zinit
#(( ${+_comps} )) && _comps[zinit]=_zinit

zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"
zstyle ':completion:*' complete true
zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"

zinit light-mode for \
    zsh-users/zsh-completions \
    zsh-users/zsh-autosuggestions \
    zdharma-continuum/fast-syntax-highlighting

if [ "$(command -v starship)" ]; then
    eval "$(starship init zsh)"
fi

if [ "$(command -v zoxide)" ]; then
    eval "$(zoxide init --cmd cd zsh)"
fi

if [ "$(command -v eza)" ]; then
    alias ls='eza --icons=always --color=always'
    alias ll='eza -l --icons=always --color=always'
    alias lla='eza -l -a --icons=always --color=always'
    alias tree='eza -l -a --icons=always --color=always --tree --git-ignore'
fi

if [ "$(command -v fzf)" ]; then
    FZF_DEFAULT_OPTS="--height=40% --layout=reverse --info=inline --border --pointer ▶"
    FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --exclude .git'
    FZF_COMPLETION_PATH_OPTS="--walker file,dir,follow,hidden"
    FZF_COMPLETION_DIR_OPTS="--walker dir,follow"

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
    zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview \
      '[[ $group == "[process ID]" ]] && ps --pid=$word -o cmd --no-headers -w -w'
    zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'
    zstyle ':fzf-tab:complete:*:*' fzf-preview 'less ${(Q)realpath}'
fi

# Load completions
autoload -Uz compinit && compinit