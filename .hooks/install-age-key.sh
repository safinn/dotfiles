#!/bin/sh
# Fetch the chezmoi age decryption key from 1Password when it's missing.
# Wired to hooks.read-source-state.pre, so it runs before any chezmoi
# command; once key.txt exists it's an instant no-op.
set -eu

KEY_FILE="$HOME/.config/chezmoi/key.txt"
OP_URI="op://Private/chezmoi age/password"

[ -f "$KEY_FILE" ] && exit 0

# On a fresh machine `chezmoi init` runs before 1Password is signed in.
# Warn instead of failing so commands that don't decrypt still work;
# decryption itself will fail until the key is in place.
if ! command -v op >/dev/null 2>&1 || ! op whoami >/dev/null 2>&1; then
    if [ "${CHEZMOI_COMMAND:-}" != "init" ]; then
        echo "warning: age key missing and 1Password CLI not signed in;" >&2
        echo "encrypted files cannot be decrypted. Sign in (1Password app ->" >&2
        echo "Settings -> Developer -> Integrate with 1Password CLI, or" >&2
        echo "'op account add') and re-run chezmoi." >&2
    fi
    exit 0
fi

umask 077
mkdir -p "$(dirname "$KEY_FILE")"
tmp=$(mktemp)
trap 'rm -f "$tmp"' EXIT
op read "$OP_URI" >"$tmp"
mv "$tmp" "$KEY_FILE"
echo "chezmoi: installed age key from 1Password to $KEY_FILE" >&2
