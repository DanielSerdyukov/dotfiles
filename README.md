# Dotfiles

Personal configuration files for macOS development environment.

## Quick Start

1. Clone this repository:
```bash
git clone https://github.com/yourusername/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

2. Install just (command runner):
```bash
brew install just
```

3. Install all configurations:
```bash
just install
```

4. Install recommended tools:
```bash
just install-tools
```

## What's Included

### Shell Configuration (Zsh)
- **History**: Shared history with deduplication
- **Completions**: Enhanced with caching and fuzzy matching
- **Plugins** (via zinit):
  - `fzf-tab` - Fuzzy completion menus
  - `zsh-syntax-highlighting` - Syntax highlighting
  - `zsh-autosuggestions` - Fish-like suggestions
  - `zsh-completions` - Additional completions

### Tools Integration
- **Starship** - Fast, customizable prompt with Catppuccin Mocha theme
- **Zoxide** - Smart directory jumping (replaces cd)
- **Eza** - Modern ls replacement with icons and git status
- **FZF** - Fuzzy finder for files, history, and completions
- **Bat** - Cat clone with syntax highlighting

### Terminal Emulator
- **Ghostty** - GPU-accelerated terminal emulator config

### Editor
- **Neovim** - Modern vim-based editor configuration

## Available Commands

Run `just` to see all available commands:

```bash
just                    # Show available commands
just install            # Install all configs
just install-zsh        # Install only zsh config
just uninstall          # Uninstall all configs
just status             # Show what's installed
just check-tools        # Check which tools are installed
just install-tools      # Install recommended tools
just update-zsh         # Update zsh plugins
```

## Key Bindings

### Shell
- `Ctrl+R` - Fuzzy search history
- `Ctrl+T` - Fuzzy find files
- `Alt+C` - Fuzzy cd to directory
- `Ctrl+←/→` - Navigate by word
- `↑/↓` - History search (cursor at end)

### Zoxide
- `cd <partial-name>` - Jump to frequently used directory
- `cdi` - Interactive directory selection

## File Structure

```
.
├── ghostty/
│   └── .config/ghostty/       # Ghostty terminal config
├── nvim/
│   └── .config/nvim/          # Neovim configuration
├── starship/
│   └── .config/starship.toml  # Starship prompt config
├── zsh/
│   ├── .zshenv                # Environment variables
│   ├── .zshrc                 # Interactive shell config
│   └── .lessfilter            # Less preprocessor
├── justfile                   # Command runner tasks
└── CLAUDE.md                  # AI assistant context
```

## Requirements

### Required
- macOS (Darwin)
- Git
- Zsh

### Recommended
- [Homebrew](https://brew.sh)
- [Just](https://github.com/casey/just) - Command runner
- [GNU Stow](https://www.gnu.org/software/stow/) - Symlink manager

### Optional Tools
Install with `just install-tools`:
- [Neovim](https://neovim.io/) - Modern vim
- [Starship](https://starship.rs/) - Shell prompt
- [Zoxide](https://github.com/ajeetdsouza/zoxide) - Smart cd
- [Eza](https://github.com/eza-community/eza) - Modern ls
- [FZF](https://github.com/junegunn/fzf) - Fuzzy finder
- [fd](https://github.com/sharkdp/fd) - Fast find
- [Bat](https://github.com/sharkdp/bat) - Cat with syntax highlighting
- [Ripgrep](https://github.com/BurntSushi/ripgrep) - Fast grep
- [Exiftool](https://exiftool.org/) - Image metadata
- [Chafa](https://hpjansson.org/chafa/) - Terminal image viewer

## XDG Base Directory

This configuration follows the [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html):

- `$XDG_CONFIG_HOME` → `~/.config` - Configuration files
- `$XDG_DATA_HOME` → `~/.local/share` - Data files
- `$XDG_CACHE_HOME` → `~/.cache` - Cache files
- `$XDG_STATE_HOME` → `~/.local/state` - State files

## Customization

To customize:

1. Edit files in `~/.dotfiles/`
2. Changes take effect immediately (files are symlinked)
3. For zsh changes, run `source ~/.zshrc` or restart shell

## Troubleshooting

### Zsh plugins not loading
```bash
just update-zsh
```

### Check installation status
```bash
just status
```

### Check which tools are missing
```bash
just check-tools
```

### Reinstall everything
```bash
just reinstall
```

## License

MIT
