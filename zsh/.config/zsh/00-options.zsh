# --- History ---
HISTFILE="$HOME/.zhistory"
HISTSIZE=10000
SAVEHIST=10000

# --- General Options ---
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits
setopt SHARE_HISTORY             # Share history between all sessions
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry
setopt HIST_VERIFY               # Don't execute immediately upon history expansion
setopt INTERACTIVE_COMMENTS      # Allow comments in interactive shell
setopt MULTIOS                   # Perform implicit tees or cats when multiple redirections are attempted
setopt PROMPT_SUBST              # Enable parameter expansion, command substitution, and arithmetic expansion in prompts
setopt NO_BEEP                   # Don't beep on errors

# --- Directory Navigation ---
setopt AUTO_CD                   # Go to folder path without using cd
setopt AUTO_PUSHD                # Push the old directory onto the stack on cd
setopt PUSHD_IGNORE_DUPS         # Do not store duplicates in the stack
setopt PUSHD_SILENT              # Do not print the directory stack after pushd or popd
