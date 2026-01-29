#!/usr/bin/env bash
# ============================================================================
# Bootstrap script for dotfiles setup
# ============================================================================

set -euo pipefail

# ============================================================================
# Detect OS
# ============================================================================
OS="$(uname -s)"
case "$OS" in
    Darwin*)
        OS_TYPE="macos"
        ;;
    Linux*)
        OS_TYPE="linux"
        ;;
    *)
        echo ""
        echo "  [✗] Unsupported OS: $OS" >&2
        exit 1
        ;;
esac

echo ""
echo "  [i] Detected OS: $OS_TYPE"

# ============================================================================
# Package lists
# ============================================================================
if [[ "$OS_TYPE" == "macos" ]]; then
    PACKAGES="stow git zoxide fd fzf eza bat exiftool starship"
else
    PACKAGES="stow git zoxide fd-find fzf ezs bat exiftool starship"
fi

# ============================================================================
# Setup package manager and install packages
# ============================================================================
if [[ "$OS_TYPE" == "macos" ]]; then
    if ! command -v brew >/dev/null 2>&1; then
        echo "  [!] Homebrew not found. Installing..."
        curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | sh

        # Source Homebrew for current session
        if [[ -f /opt/homebrew/bin/brew ]]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi

        echo "  [✓] Homebrew installed"
    fi

    # Install packages via Homebrew
    brew install ${PACKAGES} -q
fi

if [[ "$OS_TYPE" == "linux" ]]; then
    if ! command -v apt >/dev/null 2>&1; then
        echo "  [✗] apt package manager not found" >&2
        echo "  [!] Only Debian/Ubuntu-based distributions are currently supported" >&2
        exit 1
    fi

    apt -yq update && apt -yq install $PACKAGES
fi


# Create ~/.zprofile if it doesn't exist
if [[ ! -f "${HOME}/.zprofile" ]]; then
    cat > "${HOME}/.zprofile" << 'EOF'
# ============================================================================
# Package Manager (Homebrew)
# ============================================================================
if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# ============================================================================
# Cargo/Rust environment
# ============================================================================
[[ -f "${HOME}/.cargo/env" ]] && . "${HOME}/.cargo/env"
EOF
    echo "  [✓] ~/.zprofile created"
fi

echo "  [✓] Bootstrap complete"

exit 0