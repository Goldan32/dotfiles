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
export PYENV_ROOT="$HOME/.local/programs/pyenv"
[[ -d "$HOME/.local/programs/pyenv" ]] && eval "$(pyenv init -)"

# Aliases
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
if command -v bat &> /dev/null; then
    alias cat="bat -pp --theme Material-Darker"
    alias less="bat -p --theme Material-Darker"
fi

# Functions
logssh () { ssh $1 2>&1 | tee -a ~/logs/$1.$(date '+%Y.%m.%d').log; }
hg () { grep "$1" $HISTFILE }
cl () { cd $1 && ls }

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

# Prompt
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%b '
setopt PROMPT_SUBST
NEWLINE=$'\n'
PROMPT='%F{blue}%T%f %F{#D1FFBD}%n%f@${PROMPT_M} %B%F{cyan}%~%f%b %F{#FFA500}${vcs_info_msg_0_}%f${NEWLINE}%B%F{green}❯%f%b '

