# ============================================================================
# Dotfiles Management with GNU Stow
# ============================================================================

packages := "stow git zoxide fd fzf eza bat exiftool starship"

# Default recipe - show all available commands
[private]
default:
    @{{ just_executable() }} --list

# Install required packages
bootstrap:
    #!/usr/bin/env bash
    set -euo pipefail
    command -v brew >/dev/null 2>&1 || { echo "  [✗] Homebrew is not installed" >&2; exit 1; }
    for package in {{packages}}; do
        if ! command -v $package >/dev/null 2>&1; then
            brew install $package
        fi
    done

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
