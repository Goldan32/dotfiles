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

Fully functional neovim:

- Install `node`: https://nodejs.org/en/download/package-manager
- Install `pnpm`: https://pnpm.io/installation
- `npm i -g bash-language-server`
- `pnpm i -g pyright`
- `sudo apt install -y unzip`
- `cargo install stylua`
- `sudo apt install -y shellcheck`

