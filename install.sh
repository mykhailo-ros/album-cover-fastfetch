#!/bin/bash

LOGOS_DIR="$HOME/.config/fastfetch/logos"
ZSHRC="$HOME/.zshrc"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Installing Album-Cover-Fastfetch..."

if [ ! -d "$LOGOS_DIR" ]; then
    echo "   -> Creating directory: $LOGOS_DIR"
    mkdir -p "$LOGOS_DIR"
fi

echo "Pasting the latest version of script to ~/.oh-my-zsh/custom..."
if [ ! -d "$HOME/.oh-my-zsh/custom" ]; then
    echo "Error : The directory is missing."
    echo "Installation aborted"
    exit 1
fi

cp "$SCRIPT_DIR/albumfetch.zsh" "$HOME/.oh-my-zsh/custom/"

if grep -q "albumfetch()" "$ZSHRC"; then
    echo "Function call is already added to .zshrc"
else
    echo "Adding function call to .zshrc..."
    echo "albumfetch()" >> "$ZSHRC"
fi

echo "Done. Add your covers to $LOGOS_DIR."