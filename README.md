# dotfiles

Managed by [chezmoi](https://www.chezmoi.io).

## Setting up a new machine

1. Run the bootstrap script, which installs mise, then op (1Password CLI) and
   chezmoi via mise, and clones this repo:

   ```sh
   sh -c "$(curl -fsSL https://raw.githubusercontent.com/safinn/dotfiles/main/bootstrap.sh)"
   ```

2. Sign in to 1Password so chezmoi templates can read secrets:
   - with the 1Password app: enable Settings -> Developer -> Integrate with 1Password CLI
   - CLI only: `op account add` (needs your Secret Key)

3. Apply the dotfiles and install the remaining tools:

   ```sh
   chezmoi apply && mise install
   ```

## Completions

Zsh completion setup lives in `completions.zsh` and pulls from two places, both
on `fpath`:

- `~/.zsh/zsh-completions` — [zsh-users/zsh-completions](https://github.com/zsh-users/zsh-completions),
  managed as a chezmoi external (`.chezmoiexternal.toml`). Refreshed weekly, or
  on demand with `chezmoi apply --refresh-externals`.
- `~/.zsh/completions` — our own completion files, managed in
  `dot_zsh/completions/`. Add a new tool by dropping a `_toolname` file there,
  e.g. `mise completions zsh > dot_zsh/completions/_mise`.

If a newly added completion doesn't kick in, delete the compinit cache with
`rm ~/.zcompdump` and start a new shell.
