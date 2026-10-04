# --- Prompt (Starship) ---
if command -v starship &>/dev/null; then
    eval "$(starship init zsh)"
else
    # Fallback prompt if starship is not installed
    PROMPT='%F{green}%n@%m%f:%F{blue}%~%f%# '
fi
