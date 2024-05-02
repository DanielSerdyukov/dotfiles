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

### Added by Zinit's installer
if [[ ! -f $XDG_DATA_HOME/zinit/zinit.git/zinit.zsh ]]; then
    command mkdir -p "$XDG_DATA_HOME/zinit" && command chmod g-rwX "$XDG_DATA_HOME/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$XDG_DATA_HOME/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$XDG_DATA_HOME/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"
zstyle ':completion:*' complete true
zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"

if [ "$(command -v starship)" ]; then
    eval "$(starship init zsh)"
fi

if [ "$(command -v zellij)" ]; then
    # eval "$(zellij setup --generate-auto-start zsh)"
fi

if [ "$(command -v fzf)" ]; then
    FZF_DEFAULT_OPTS="--height=40% --layout=reverse --info=inline --border --pointer ▶"
    FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --exclude .git'

    eval "$(fzf --zsh)"

    _fzf_compgen_path() {
        fd --hidden --follow --exclude ".git" . "$1"
    }

    _fzf_compgen_dir() {
        fd --type d --hidden --follow --exclude ".git" . "$1"
    }

    _fzf_comprun() {
        local command=$1
        shift

        case "$command" in
        export|unset) fzf --preview "eval 'echo \$'{}"            "$@" ;;
        ssh)          fzf --preview 'dig {}'                      "$@" ;;
        *)            fzf --preview '$ZDATADIR/fzf-preview.sh {}' "$@" ;;
        esac
    }

    zinit light Aloxaf/fzf-tab
    zstyle ':completion:*' menu no
    zstyle ':fzf-tab:*' fzf-flags --height=40% --layout=reverse --info=inline --border --pointer ▶
    zstyle ':fzf-tab:complete:*:*' fzf-preview '$ZDATADIR/fzf-preview.sh $realpath'
fi

if [ "$(command -v zoxide)" ]; then
    eval "$(zoxide init zsh)"
    alias cd='z'
fi

if [ "$(command -v eza)" ]; then
    alias ls='eza --icons=always --color=always'
    alias ll='eza -l --icons=always --color=always'
    alias lla='eza -l -a --icons=always --color=always'
    alias tree='eza -l -a --icons=always --color=always --tree --git-ignore'
fi

zinit wait lucid for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
 blockf \
    zsh-users/zsh-completions \
 atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions
