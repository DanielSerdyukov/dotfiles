# ============================================================================
# Dotfiles Management with GNU Stow
# ============================================================================
# This justfile provides commands to manage dotfiles using GNU Stow.
# Stow creates symlinks from this repository to your home directory.
#
# Usage:
#   just                  # Show all available commands
#   just bootstrap        # Install stow if not present
#   just install zsh      # Enable zsh configuration
#   just uninstall nvim   # Disable neovim configuration
#
# Prerequisites:
#   - GNU Stow (installed automatically via bootstrap)
#   - macOS (brew) or Debian-based Linux (apt)

# Default recipe - show all available commands
default:
    @just --list

# Check that `GNU Stow` if installed
[private]
bootstrap:
    @command ! -v stow &>/dev/null && echo "" && echo "  [✗] GNU Stow is not installed" && echo "" && exit 1;

# Enable a configuration (ghostty, nvim, starship, or zsh)
install recipe: bootstrap
    @stow -t ~ {{recipe}}
    @echo ""
    @echo "  [✓] {{recipe}} configuration enabled"

# Disable a configuration (ghostty, nvim, starship, or zsh)
uninstall recipe: bootstrap
    @stow -t ~ -D {{recipe}}
    @echo ""
    @echo "  [✗] {{recipe}} configuration disabled"

# Show which configurations are currently linked
status:
    @echo "=== Dotfiles Status ==="
    @echo ""
    @echo "Zsh:"
    @[[ -L ~/.zshrc ]] && echo "  [✓] .zshrc is linked" || echo "  [✗] .zshrc not linked"
    @[[ -L ~/.zshenv ]] && echo "  [✓] .zshenv is linked" || echo "  [✗] .zshenv not linked"
    @[[ -L ~/.lessfilter ]] && echo "  [✓] .lessfilter is linked" || echo "  [✗] .lessfilter not linked"
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

# Check if required and optional tools are installed
doctor:
    @echo "=== Healthcheck ==="
    @echo ""
    @command -v git &>/dev/null && echo "  [✓] git" || echo "  [✗] git (required)"
    @command -v starship &>/dev/null && echo "  [✓] starship" || echo "  [✗] starship"
    @command -v zoxide &>/dev/null && echo "  [✓] zoxide" || echo "  [✗] zoxide"
    @command -v eza &>/dev/null && echo "  [✓] eza" || echo "  [✗] eza"
    @command -v fzf &>/dev/null && echo "  [✓] fzf" || echo "  [✗] fzf"
    @command -v bat &>/dev/null && echo "  [✓] bat" || echo "  [✗] bat"
    @command -v ripgrep &>/dev/null && echo "  [✓] ripgrep" || echo "  [✗] ripgrep"
    @command -v exiftool &>/dev/null && echo "  [✓] exiftool" || echo "  [✗] exiftool"
    @command -v chafa &>/dev/null && echo "  [✓] chafa" || echo "  [✗] chafa"