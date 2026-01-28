# Dotfiles

Personal configuration files for macOS development environment, managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Overview

This repository contains configuration files for:

- **Zsh** - Shell configuration with modern plugins and enhancements
- **Starship** - Fast, customizable shell prompt
- **Neovim** - Text editor configuration
- **Ghostty** - Terminal emulator settings

## Prerequisites

- **Homebrew** - Package manager for installing tools
- **GNU Stow** - Symlink manager for dotfiles

Install Homebrew if not already installed:
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## Quick Start

1. Clone this repository:
```bash
git clone <repository-url> ~/.dotfiles
cd ~/.dotfiles
```

2. Install required packages:
```bash
just bootstrap
```

3. Link the configurations you want:
```bash
just link zsh
just link starship
just link nvim
just link ghostty
```

4. Check the status of your linked configurations:
```bash
just status
```

## Tools Installed

The `bootstrap` recipe installs these essential tools via Homebrew:

- **stow** - GNU Stow symlink manager
- **git** - Version control
- **zoxide** - Smart directory jumper
- **fd** - Fast alternative to find
- **fzf** - Fuzzy finder for files and history
- **eza** - Modern ls replacement
- **bat** - cat with syntax highlighting
- **exiftool** - Read/write metadata in files
- **starship** - Cross-shell prompt

## Available Commands

| Command | Description |
|---------|-------------|
| `just bootstrap` | Install required packages via Homebrew |
| `just link <config>` | Link a configuration (e.g., `just link zsh`) |
| `just unlink <config>` | Unlink a configuration (e.g., `just unlink zsh`) |
| `just status` | Show which configurations are currently linked |

## Directory Structure

Each tool's configuration is stored in its own directory:

```
.
├── ghostty/          # Ghostty terminal emulator
│   └── .config/ghostty/
├── nvim/             # Neovim editor
│   └── .config/nvim/
├── starship/         # Starship prompt
│   └── .config/starship.toml
└── zsh/              # Zsh shell
    ├── .zshenv       # Environment variables
    ├── .zshrc        # Interactive shell config
    └── .lessfilter   # Less pager preprocessor
```

## Zsh Features

### Plugin Manager
- **Zinit** - Fast, flexible plugin manager
- Auto-installs on first run
- XDG Base Directory compliant

### Installed Plugins
- `zsh-syntax-highlighting` - Command syntax highlighting
- `zsh-autosuggestions` - Fish-like command suggestions
- `zsh-completions` - Additional completion definitions
- `fzf-tab` - Fuzzy finder for completion menu

### Key Bindings
- `Ctrl+T` - Fuzzy find files in current directory
- `Ctrl+R` - Fuzzy search command history
- `Alt+C` - Fuzzy cd into directory

### Enhanced Commands
- `cd` - Replaced with zoxide for smart directory navigation
- `cdi` - Interactive directory selection
- `ls` - Replaced with eza (colorized, directories first)
- `ll` - Long format with icons and git status
- `lla` - Long format including hidden files
- `lt` - Tree view with icons

### Less Pager Enhancement
The `.lessfilter` script provides rich previews for `less`:
- **Directories** - Tree view with eza
- **Code/Text** - Syntax highlighting with bat
- **Images** - Preview metadata with exiftool

All features gracefully fallback to standard tools if optional dependencies are missing.

## Configuration Philosophy

- **XDG Compliance** - Follow XDG Base Directory specification
- **Graceful Fallbacks** - Work without optional dependencies
- **PATH Management** - Only `~/.local/bin` is added to PATH
- **Minimal & Focused** - Clean configurations without bloat

## Uninstalling

To remove configurations:

```bash
just unlink zsh
just unlink starship
just unlink nvim
just unlink ghostty
```
