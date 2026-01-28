# Dotfiles

Personal configuration files for macOS development environment.

## Quick Start

1. Clone this repository:
```bash
git clone https://github.com/yourusername/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

2. Install dependencies:
```bash
brew install just stow
```

3. Install configurations:
```bash
just install zsh
just install starship
# Or install others: ghostty, nvim
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
just                      # Show available commands
just install <package>    # Enable a configuration (ghostty, nvim, starship, zsh)
just uninstall <package>  # Disable a configuration
just status               # Show which configurations are linked
just doctor               # Check if required and optional tools are installed
```

### Examples

```bash
# Install specific configs
just install zsh
just install starship

# Uninstall a config
just uninstall nvim

# Check what's installed
just status

# Check which tools you have
just doctor
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
Check what you have installed with `just doctor`, then install via Homebrew:
- [Neovim](https://neovim.io/) - Modern vim (`brew install neovim`)
- [Starship](https://starship.rs/) - Shell prompt (`brew install starship`)
- [Zoxide](https://github.com/ajeetdsouza/zoxide) - Smart cd (`brew install zoxide`)
- [Eza](https://github.com/eza-community/eza) - Modern ls (`brew install eza`)
- [FZF](https://github.com/junegunn/fzf) - Fuzzy finder (`brew install fzf`)
- [fd](https://github.com/sharkdp/fd) - Fast find (`brew install fd`)
- [Bat](https://github.com/sharkdp/bat) - Cat with syntax highlighting (`brew install bat`)
- [Ripgrep](https://github.com/BurntSushi/ripgrep) - Fast grep (`brew install ripgrep`)
- [Exiftool](https://exiftool.org/) - Image metadata (`brew install exiftool`)
- [Chafa](https://hpjansson.org/chafa/) - Terminal image viewer (`brew install chafa`)

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

### Check installation status
```bash
just status
```

### Check which tools are installed
```bash
just doctor
```

### GNU Stow not found
```bash
brew install stow
```

### Reinstall a configuration
```bash
just uninstall zsh
just install zsh
```

## License

MIT
