# Dotfiles management with GNU Stow
# Run `just --list` to see all available commands

# Default recipe - show help
default:
    @just --list

# Install all configurations
install: install-zsh install-starship install-nvim install-ghostty
    @echo "✓ All configurations installed"

# Install zsh configuration
install-zsh:
    @echo "Installing zsh config..."
    @if command -v stow &>/dev/null; then \
        stow -v -t ~ zsh; \
    else \
        ln -sf "{{justfile_directory()}}/zsh/.zshrc" ~/.zshrc; \
        ln -sf "{{justfile_directory()}}/zsh/.zshenv" ~/.zshenv; \
        ln -sf "{{justfile_directory()}}/zsh/.lessfilter" ~/.lessfilter; \
    fi
    @echo "✓ Zsh config installed"

# Install starship configuration
install-starship:
    @echo "Installing starship config..."
    @mkdir -p ~/.config
    @if command -v stow &>/dev/null; then \
        stow -v -t ~ starship; \
    else \
        ln -sf "{{justfile_directory()}}/starship/.config/starship.toml" ~/.config/starship.toml; \
    fi
    @echo "✓ Starship config installed"

# Install neovim configuration
install-nvim:
    @echo "Installing nvim config..."
    @mkdir -p ~/.config
    @if command -v stow &>/dev/null; then \
        stow -v -t ~ nvim; \
    else \
        ln -sf "{{justfile_directory()}}/nvim/.config/nvim" ~/.config/nvim; \
    fi
    @echo "✓ Neovim config installed"

# Install ghostty configuration
install-ghostty:
    @echo "Installing ghostty config..."
    @mkdir -p ~/.config
    @if command -v stow &>/dev/null; then \
        stow -v -t ~ ghostty; \
    else \
        ln -sf "{{justfile_directory()}}/ghostty/.config/ghostty" ~/.config/ghostty; \
    fi
    @echo "✓ Ghostty config installed"

# Uninstall all configurations
uninstall: uninstall-zsh uninstall-starship uninstall-nvim uninstall-ghostty
    @echo "✓ All configurations uninstalled"

# Uninstall zsh configuration
uninstall-zsh:
    @echo "Uninstalling zsh config..."
    @if command -v stow &>/dev/null; then \
        stow -v -D -t ~ zsh; \
    else \
        rm -f ~/.zshrc ~/.zshenv ~/.lessfilter; \
    fi
    @echo "✓ Zsh config uninstalled"

# Uninstall starship configuration
uninstall-starship:
    @echo "Uninstalling starship config..."
    @if command -v stow &>/dev/null; then \
        stow -v -D -t ~ starship; \
    else \
        rm -f ~/.config/starship.toml; \
    fi
    @echo "✓ Starship config uninstalled"

# Uninstall neovim configuration
uninstall-nvim:
    @echo "Uninstalling nvim config..."
    @if command -v stow &>/dev/null; then \
        stow -v -D -t ~ nvim; \
    else \
        rm -f ~/.config/nvim; \
    fi
    @echo "✓ Neovim config uninstalled"

# Uninstall ghostty configuration
uninstall-ghostty:
    @echo "Uninstalling ghostty config..."
    @if command -v stow &>/dev/null; then \
        stow -v -D -t ~ ghostty; \
    else \
        rm -f ~/.config/ghostty; \
    fi
    @echo "✓ Ghostty config uninstalled"

# Reinstall all configurations (uninstall then install)
reinstall: uninstall install
    @echo "✓ All configurations reinstalled"

# Show installation status
status:
    @echo "=== Dotfiles Installation Status ==="
    @echo ""
    @echo "Zsh:"
    @if [ -L ~/.zshrc ]; then echo "  ✓ .zshrc -> $(readlink ~/.zshrc)"; else echo "  ✗ .zshrc not linked"; fi
    @if [ -L ~/.zshenv ]; then echo "  ✓ .zshenv -> $(readlink ~/.zshenv)"; else echo "  ✗ .zshenv not linked"; fi
    @if [ -L ~/.lessfilter ]; then echo "  ✓ .lessfilter -> $(readlink ~/.lessfilter)"; else echo "  ✗ .lessfilter not linked"; fi
    @echo ""
    @echo "Starship:"
    @if [ -L ~/.config/starship.toml ]; then echo "  ✓ starship.toml -> $(readlink ~/.config/starship.toml)"; else echo "  ✗ starship.toml not linked"; fi
    @echo ""
    @echo "Neovim:"
    @if [ -L ~/.config/nvim ]; then echo "  ✓ nvim -> $(readlink ~/.config/nvim)"; else echo "  ✗ nvim not linked"; fi
    @echo ""
    @echo "Ghostty:"
    @if [ -L ~/.config/ghostty ]; then echo "  ✓ ghostty -> $(readlink ~/.config/ghostty)"; else echo "  ✗ ghostty not linked"; fi
    @echo ""

# Check for required and optional tools
check-tools:
    @echo "=== Required Tools ==="
    @command -v git &>/dev/null && echo "✓ git" || echo "✗ git (required)"
    @command -v zsh &>/dev/null && echo "✓ zsh" || echo "✗ zsh (required)"
    @echo ""
    @echo "=== Package Managers ==="
    @command -v brew &>/dev/null && echo "✓ homebrew" || echo "✗ homebrew"
    @command -v stow &>/dev/null && echo "✓ stow (using stow for symlinks)" || echo "✗ stow (falling back to manual symlinks)"
    @echo ""
    @echo "=== Optional Tools ==="
    @command -v nvim &>/dev/null && echo "✓ neovim" || echo "✗ neovim"
    @command -v starship &>/dev/null && echo "✓ starship" || echo "✗ starship"
    @command -v ghostty &>/dev/null && echo "✓ ghostty" || echo "✗ ghostty"
    @command -v zoxide &>/dev/null && echo "✓ zoxide" || echo "✗ zoxide"
    @command -v eza &>/dev/null && echo "✓ eza" || echo "✗ eza"
    @command -v fzf &>/dev/null && echo "✓ fzf" || echo "✗ fzf"
    @command -v fd &>/dev/null && echo "✓ fd" || echo "✗ fd"
    @command -v bat &>/dev/null && echo "✓ bat" || echo "✗ bat"
    @command -v ripgrep &>/dev/null && echo "✓ ripgrep" || echo "✗ ripgrep"
    @command -v exiftool &>/dev/null && echo "✓ exiftool" || echo "✗ exiftool"
    @command -v chafa &>/dev/null && echo "✓ chafa" || echo "✗ chafa"
    @echo ""

# Install recommended tools via homebrew
install-tools:
    @echo "Installing recommended tools..."
    @if ! command -v brew &>/dev/null; then \
        echo "✗ Homebrew not found. Please install from https://brew.sh"; \
        exit 1; \
    fi
    brew install stow neovim starship zoxide eza fzf fd bat ripgrep exiftool chafa
    @echo "✓ Tools installed"

# Update zinit and plugins
update-zsh:
    @echo "Updating zinit and zsh plugins..."
    @zsh -c "source ~/.zshrc && zinit self-update && zinit update --all"
    @echo "✓ Zsh plugins updated"
