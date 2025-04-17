## Tools
- [Cargo](https://www.rust-lang.org/tools/install)
- [FZF](https://github.com/junegunn/fzf) (>=0.48.0)
- [Chafa](https://github.com/hpjansson/chafa) (optional)
- [Stow](https://www.gnu.org/software/stow/) (optional)
- [Starship](https://starship.rs) (prompt)
- [Wezterm](https://wezterm.org) (terminal)

## Installation

### MacOS
#### Prompt
```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

```bash
brew install cmake fzf chafa stow
```

```bash
git clone https://github.com/DanielSerdyukov/dotfiles.git ~/.dotfiles
```

```bash
cp ~/.dotfiles/fonts/.local/share/fonts/*.ttf ~/Library/Fonts/
```

```bash
cd ~/.dotfiles && stow zsh && exec zsh
```

```bash
cargo install eza bat fd-find ripgrep zoxide starship
```

```bash
cd ~/.dotfiles && stow starship && exec zsh
```

#### Terminal
```bash
cargo install wezterm
```

```bash
cd ~/.dotfiles && stow wezterm && exec zsh
```