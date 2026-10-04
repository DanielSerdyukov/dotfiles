# ~/.zshrc
for f in "$HOME"/.config/zsh/[0-9]*.zsh(N); do
  source "$f"
done
