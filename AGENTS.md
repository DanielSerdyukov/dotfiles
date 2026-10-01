# AGENTS.md

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/). Each top-level directory is a stow package; stowing creates symlinks from `~` into this repo.

## Structure

- One directory per tool (e.g. `nvim/`), mirroring the home directory layout inside it: `nvim/.config/nvim/...` → `~/.config/nvim/...`.
- `.luarc.json` and `.pi/` are repo-local tooling config for agents/LSP — they are not stow packages; never stow them.
- This repo is the source of truth. Never edit config directly in `~/.config` unless you've confirmed it is not a symlink into this repo.

## Stow commands

Run from the repo root:

```sh
stow -n -v <pkg>    # dry-run: verify what would be linked before changing anything
stow -t ~ <pkg>     # apply a package
stow -R -t ~ <pkg>  # restow after adding/removing/moving files inside a package
```

- After adding, deleting, or moving files within a package, restow that package (`stow -R`). Plain `stow` won't prune removed links.
- If stow reports a conflict, a real file exists at the target path. Inspect it (`ls -la`), back it up or delete it if it's disposable, and retry. Never force over unrelated target files.

## Conventions

- New tool config goes in a new top-level package named after the tool, with the target paths mirrored underneath (`<pkg>/.config/<tool>/...`, `<pkg>/.zshrc`, etc.).
- Never place stowable files loose at the repo root.
- Packages must not nest; keep one tool per package.
- Match the existing style of the tool's config (Lua for nvim, etc.).
- `zsh/.zshrc` sources machine-local drop-ins from `~/.config/zsh.d/*.zsh`. That directory is intentionally outside this repo — never stow, track, or "helpfully" create it.

## Verification

- `stow -n -v <pkg>` exits cleanly → package layout is valid.
- After restowing, confirm symlinks resolve: `ls -la ~/.config/<tool>`.
