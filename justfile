# ============================================================================
# Dotfiles Management with GNU Stow
# ============================================================================

# Default recipe - show all available commands
[private]
default:
    @{{ just_executable() }} --list

# Install required packages and setup environment
bootstrap:
    @./bootstrap.sh

# Link a config (e.g., ghostty, nvim, starship, zsh)
link config: bootstrap
    @stow -t ~ {{config}}
    @echo ""
    @echo "  [✓] {{config}} config enabled"

# Unlink a config (e.g., ghostty, nvim, starship, zsh)
unlink config: bootstrap
    @stow -t ~ {{config}}
    @echo ""
    @echo "  [✗] {{config}} config disabled"

# Show which configurations are currently linked
status:
    @echo "=== Dotfiles Status ==="
    @echo ""
    @echo "Zsh:"
    @[[ -L ~/.zshrc ]] && echo "  [✓] .zshrc is linked" || echo "  [✗] .zshrc not linked"
    @[[ -L ~/.zshenv ]] && echo "  [✓] .zshenv is linked" || echo "  [✗] .zshenv not linked"
    @[[ -L ~/.lessfilter ]] && echo "  [✓] .lessfilter is linked" || echo "  [✗] .lessfilter not linked"
    @[[ -f ~/.zprofile ]] && echo "  [✓] .zprofile exists" || echo "  [✗] .zprofile not found"
    @echo ""
    @echo "Starship:"
    @[[ -L ~/.config/starship.toml ]] && echo "  [✓] starship is linked" || echo "  [✗] starship not linked"
    @echo ""
    @echo "Neovim:"
    @[[ -L ~/.config/nvim ]] && echo "  [✓] nvim is linked" || echo "  [✗] nvim not linked"
    @echo ""
    @echo "Ghostty:"
    @[[ -L ~/.config/ghostty ]] && echo "  [✓] ghostty is linked" || echo "  [✗] ghostty not linked"
    @echo ""
