# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a dotfiles repository for managing personal configuration files across development environments. The repository uses a structured approach where each tool's configuration is stored in its own directory with a `.config` subdirectory, mirroring the typical `~/.config` structure.

**User-facing documentation is in README.md** - refer users there for setup instructions, tool lists, and usage. This file contains technical details for AI assistance.

## Directory Structure

```
.
├── ghostty/          # Ghostty terminal emulator config
│   └── .config/
├── nvim/             # Neovim editor config
│   └── .config/nvim/
├── starship/         # Starship prompt config
│   └── .config/starship.toml
└── zsh/              # Zsh shell config
    ├── .zshenv       # Environment variables (sourced for all zsh invocations)
    └── .zshrc        # Interactive shell configuration
```

Each tool directory contains a `.config` subdirectory that mirrors where the config would normally be installed in the home directory (e.g., `nvim/.config/nvim/` maps to `~/.config/nvim/`).

## Configuration Files

### Zsh Configuration
- **`.zshenv`**: Environment variables, PATH, and non-interactive settings. Sourced for all zsh invocations.
- **`.zshrc`**: Interactive shell configuration (history, completions, aliases, key bindings, prompt).

### Plugin Manager (Zinit)
- Fast and flexible zsh plugin manager
- Installed in `$XDG_DATA_HOME/zinit` for XDG compliance
- Auto-installs on first run if not present
- Current plugins:
  - `zsh-syntax-highlighting` - Syntax highlighting for commands
  - `zsh-autosuggestions` - Fish-like autosuggestions
  - `zsh-completions` - Additional completion definitions
  - `Aloxaf/fzf-tab` - Replace zsh completion menu with fzf

### FZF (Fuzzy Finder)
- Command-line fuzzy finder for files, history, and more
- Key bindings:
  - `Ctrl+T` - Fuzzy find files in current directory
  - `Ctrl+R` - Fuzzy search command history
  - `Alt+C` - Fuzzy cd into directory
- Uses `fd` for faster file/directory search if available
- Integration with `fzf-tab` for fuzzy completion menus
- Preview directory contents with `eza` when completing `cd`
- Switch completion groups with `<` and `>`

### Directory Navigation & File Listing
- **Zoxide**: Smart cd replacement that learns frequently visited directories
  - Integrated with `--cmd cd` to replace standard `cd` command
  - Jump to frequently used directories with partial names
  - Use `cdi` for interactive directory selection

- **Eza**: Modern ls replacement with better colors and features
  - `ls` - List files with colors and directories first
  - `ll` - Long format with icons and git status
  - `lla` - Long format including hidden files
  - `lt` - Tree view with icons
  - Graceful fallback to standard `ls` if eza is not installed

### Less Pager Enhancement
- **`.lessfilter`**: Preprocessor for `less` command located at `~/.lessfilter`
- Provides rich previews for different file types:
  - **Directories**: Tree view with eza (with icons) or ls fallback
  - **Code/Text**: Syntax highlighting with bat or plain cat
  - **Images**: Shows image (chafa) or metadata (exiftool)
- Referenced in `.zshenv` via `LESSOPEN` environment variable
- Graceful fallbacks when tools (bat, eza, chafa, exiftool) are not installed

### Important Rules
- **PATH Management**: Only `~/.local/bin` should be added to PATH. Never add `~/bin` to PATH configuration.
- **XDG Compliance**: Follow XDG Base Directory specification for all data/config/cache paths.
