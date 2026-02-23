#!/usr/bin/env bash
# install.sh — create symlinks for all dotfiles (Linux & macOS)
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Detect OS for VS Code settings path
if [[ "$OSTYPE" == darwin* ]]; then
    VSCODE_SETTINGS_DIR="$HOME/Library/Application Support/Code/User"
else
    VSCODE_SETTINGS_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/Code/User"
fi

link() {
    local src="$1" dst="$2"
    local dir
    dir="$(dirname "$dst")"
    mkdir -p "$dir"
    if [ -e "$dst" ] && [ ! -L "$dst" ]; then
        echo "  [backup] $dst -> $dst.bak"
        mv "$dst" "$dst.bak"
    fi
    ln -sfv "$src" "$dst"
}

echo "==> Linking git"
link "$DOTFILES_DIR/git/.gitconfig"        "$HOME/.gitconfig"
link "$DOTFILES_DIR/git/.gitignore_global" "$HOME/.gitignore_global"

echo "==> Linking shell"
link "$DOTFILES_DIR/shell/.profile"  "$HOME/.profile"
link "$DOTFILES_DIR/shell/.bashrc"   "$HOME/.bashrc"
link "$DOTFILES_DIR/shell/.zshrc"    "$HOME/.zshrc"

echo "==> Linking VS Code settings"
link "$DOTFILES_DIR/vscode/settings.json" "$VSCODE_SETTINGS_DIR/settings.json"

echo ""
echo "Done! Restart your shell or run: source ~/.bashrc"
