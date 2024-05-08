#!/bin/sh

# history
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_dups

# plugins
source ~/.zsh/scripts/plugin_utils
load_plugin zsh-autosuggestions
load_plugin zsh-syntax-highlighting
load_plugin zsh-vi-mode jeffreytse

# Disable underline for syntax highlights
(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none

# exports
export PATH=$HOME/.cargo/bin:$PATH
export EDITOR="vi"

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# ls aliases
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'

alias ssh='ssh -A'

logssh () { ssh $1 2>&1 | tee -a ~/logs/$1.$(date '+%Y.%m.%d').log; }

if command -v bat &> /dev/null; then
    alias cat="bat -pp --theme Material-Darker"
fi

# keybinds
# bindkey '^I' autosuggest-accept

# Prompt
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%b '
setopt PROMPT_SUBST
NEWLINE=$'\n'
PROMPT='%F{blue}%T%f %F{#D1FFBD}%n%f %B%F{cyan}%~%f%b %F{#FFA500}${vcs_info_msg_0_}%f${NEWLINE}%B%F{green}❯%f%b '
