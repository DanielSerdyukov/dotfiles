# --- Aliases ---
# Directory listing (eza if available, otherwise fallback to ls)
if command -v eza &>/dev/null; then
    alias ls='eza --color --icons --group-directories-first'
    alias ll='eza -l --color --icons --git --group-directories-first'
    alias lla='eza -la --color --icons --git --group-directories-first'
    alias lt='eza -la --color --icons --git --group-directories-first --tree --git-ignore --level 5'
    alias tree='eza -la --color --icons --git --group-directories-first --tree --git-ignore --level 5'
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
