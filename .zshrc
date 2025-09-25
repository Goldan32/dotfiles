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
export NVM_DIR="$HOME/.local/programs/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
case ":$PATH:" in
    *":$HOME/.local/bin:"*) ;;
    *) export PATH="$HOME/.local/bin:$PATH" ;;
esac
export PYENV_ROOT="$HOME/.local/programs/pyenv"
[[ -d "$HOME/.local/programs/pyenv" ]] && \
case ":$PATH:" in
    *":$PYENV_ROOT:"*) ;;
    *) export PATH="$PYENV_ROOT/bin:$PATH" ;;
esac
eval "$(pyenv init -)"

eval "$(zoxide init zsh)"
alias cd='z'

# Defaults
export EDITOR="nvim"
export KERNEL_VERSION="$(uname -r)"

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
alias cb='wl-copy'
alias fd='fdfind'
alias v='nvim'
if command -v bat &> /dev/null; then
    alias cat="bat -pp --theme Material-Darker"
    alias less="bat -p --theme Material-Darker"
fi

# Functions
logssh () { ssh $1 2>&1 | tee -a ~/.session_logs/$1.$(date '+%Y.%m.%d').log; }

hg () { rg -N "$1" $HISTFILE }

bflash () {
    if [ $# -ne 2 ]; then echo "bflash img_file location"; exit 1; fi
    bmaptool create "$1" > "$1.bmap" && \
    bmaptool copy "$1" "$2" && \
    rm "$1.bmap"
}

ff () { realpath "$(find ./ -iname $1)" }

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

nohup () { command nohup "$@" > /dev/null 2>&1 }

# Keybinds
bindkey -M vicmd "k" history-beginning-search-backward
bindkey -M vicmd "j" history-beginning-search-forward
bindkey -r "^[c"
zvm_bindkey vicmd 'a'  zvm_append_eol

PROMPT_M='%m'

MACHINE_ENV="${HOME}/.zsh/machines/${(L)$(cat /sys/class/dmi/id/product_family | cut -d ' ' -f 1)}.sh"
if [ -f ${MACHINE_ENV} ]; then
    . ${MACHINE_ENV}
fi

UNTRACKED_ENV="${HOME}/.zsh/local/env.sh"
if [ -f ${UNTRACKED_ENV} ]; then
    . ${UNTRACKED_ENV}
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

