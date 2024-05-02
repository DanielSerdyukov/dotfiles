eval "$(/opt/homebrew/bin/brew shellenv)"

if [ "$(command -v conda)" ]; then
    eval "$(conda "shell.$(basename "${SHELL}")" hook)"
fi
