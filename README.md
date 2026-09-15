# Dotfiles

Collection of my configs for various programs.

## Standalone usage

To create symlinks sensibly, use

```bash
stow --no-folding .
```

Install cargo and bat, activate bat theme

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cargo install bat
bat cache --build
```

Install neovim using `bob` (must use `bob`, `nvim`, executable points to it in `.zshrc`)

```bash
cargo install bob-nvim && \
bob install nightly && \
bob use nightly
```

## Usage with home-manager

This repo is included as a submodule in my [home-manager config](https://github.com/Goldan32/nix-home), which performs the necessary link creations when activated.
