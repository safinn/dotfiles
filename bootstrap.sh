#!/bin/sh
set -eu

# Bootstrap a fresh machine: install mise, use mise to install the 1Password
# CLI and chezmoi, then pull the dotfiles with chezmoi init.

if ! command -v mise >/dev/null 2>&1 && [ ! -x "$HOME/.local/bin/mise" ]; then
    echo "Installing mise..."
    curl -fsSL https://mise.run | sh
fi
export PATH="$HOME/.local/bin:$HOME/.local/share/mise/shims:$PATH"

mise use --global 1password@latest chezmoi@latest

chezmoi init safinn/dotfiles

echo ""
echo "Dotfiles cloned. chezmoi templates read secrets from 1Password, so sign in first:"
echo "  - macOS: open the 1Password app and enable Settings -> Developer -> Integrate with 1Password CLI"
echo "  - otherwise: run 'op account add'"
echo "Then run: chezmoi apply && mise install"
