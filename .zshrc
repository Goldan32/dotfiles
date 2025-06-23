#!/bin/sh

# History
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_dups

# Plugins
source ~/.zsh/scripts/plugin_utils.sh
load_plugin zsh-autosuggestions
load_plugin zsh-syntax-highlighting
load_plugin --user jeffreytse --hash 287efa19ec492b2f24bb93d1f4eaac3049743a63 --patch zsh-vi-mode

# Disable underline for syntax highlights
(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none

# Exports
case ":$PATH:" in
    *":$HOME/.cargo/bin:"*) ;;
    *) export PATH="$HOME/.cargo/bin:$PATH" ;;
esac
export EDITOR="nvim"
export PNPM_HOME="${HOME}/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
case ":$PATH:" in
    *":$HOME/.local/bin:"*) ;;
    *) export PATH="$HOME/.local/bin:$PATH" ;;
esac
case ":$PATH:" in
    *":$HOME/.elixir-install/installs/elixir/1.18.3-otp-27/bin:"*) ;;
    *) export PATH="$HOME/.elixir-install/installs/elixir/1.18.3-otp-27/bin:$PATH" ;;
esac
case ":$PATH:" in
    *":$HOME/.elixir-install/installs/otp/27.1.2/bin:"*) ;;
    *) export PATH="$HOME/.elixir-install/installs/otp/27.1.2/bin:$PATH" ;;
esac
export PYENV_ROOT="$HOME/.local/programs/pyenv"
[[ -d "$HOME/.local/programs/pyenv" ]] && eval "$(pyenv init -)"

# Try to fix wayland on home-pc
export LIBVA_DRIVER_NAME=nvidia
export GBM_BACKEND=nvidia-drm
export __GLX_VENDOR_LIBRARY_NAME=nvidia
export WLR_NO_HARDWARE_CURSORS=1

# Aliases
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias lock='hyprlock'
alias msub='mosquitto_sub'
alias mpub='mosquitto_pub'
# write `env` in front to bind to keyboard shortcut
alias wezeditor='WEZTERM_EDITOR_LAYOUT=1 wezterm start --always-new-process'
if command -v bat &> /dev/null; then
    alias cat="bat -pp --theme Material-Darker"
    alias less="bat -p --theme Material-Darker"
fi

# Functions
logssh () { ssh $1 2>&1 | tee -a ~/logs/$1.$(date '+%Y.%m.%d').log; }
hg () { grep "$1" $HISTFILE }
cl () { cd $1 && ls }
bflash () {
    if [ $# -ne 2 ]; then echo "bflash img_file location"; exit 1; fi
    bmaptool create "$1" > "$1.bmap" && \
    bmaptool copy "$1" "$2" && \
    rm "$1.bmap"
}
ff () {
    realpath "$(find ./ -iname $1)"
}

NVIM_BIN="${HOME}/.local/share/bob/nvim-bin/nvim"
nvim () {
    if [ -z $1 ]; then
        "$NVIM_BIN"
    elif [ -d "$1" ]; then
        "${NVIM_BIN}" --cmd "cd $1"
    else
        "${NVIM_BIN}" "$1"
    fi
}

# Keybinds
bindkey -M vicmd "k" history-beginning-search-backward
bindkey -M vicmd "j" history-beginning-search-forward
bindkey -r "^[c"
zvm_bindkey vicmd 'a'  zvm_append_eol

if [ -f /.dockerenv ]; then
    PROMPT_M='%F{red}container%f'
else
    PROMPT_M='%m'
fi

# Source local configs
if [ -f ~/.myenv ]; then
    . ~/.myenv
fi

if [[ -v ZELLIJ ]]; then
    PROMPT_M="🟩🟩🟩${PROMPT_M}🟩🟩🟩"
fi

# Prompt
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%b '
setopt PROMPT_SUBST
NEWLINE=$'\n'
PROMPT='%F{blue}%T%f %F{#D1FFBD}%n%f@${PROMPT_M} %B%F{cyan}%~%f%b %F{#FFA500}${vcs_info_msg_0_}%f${NEWLINE}%B%F{green}❯%f%b '

