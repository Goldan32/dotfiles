# Dotfiles

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

Fully functional neovim:

- Install `node`: https://nodejs.org/en/download/package-manager
- Install `pnpm`: https://pnpm.io/installation
- `npm i -g bash-language-server`
- `npm i -g markdownlint-cli`
- `npm i -g typescript typescript-language-server`
- `npm i -g prettier`
- `npm i -g svelte`
- `pnpm i -g pyright`
- `sudo apt install -y unzip`
- `cargo install stylua`
- `sudo apt install -y shellcheck`


Hyprland checklist:

- [x] Sound settings: `pavucontrol`
- [x] Bluetooth headset: `bluetoothctl` for connecting a bluetooth device
- [x] Screen sharing: Works if installed via script
- [x] Checking battery percantage: `acpi`
- [ ] Wifi connection script with `nmcli`
- [ ] Screen locking
- [ ] Faster key inputs on holding a key
- [ ] A statusline on the bottom
- [ ] Power saving modes
- [ ] Fingerprint sensor
- [ ] Full custom keybinds
- [ ] Per-system configs
