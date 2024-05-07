# Dotfiles

To create symlinks sensibly, use

```bash
stow --no-folding .
```

This should really be the default behavior imo.

Install cargo and bat, activate bat theme

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cargo install bat
bat cache --build
```

