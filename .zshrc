#!/bin/sh

# history
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

# plugins
source ~/.zsh/scripts/plugin_utils
load_plugin zsh-autosuggestions
load_plugin zsh-syntax-highlighting
source ~/.zsh/zsh-vi-mode/zsh-vi-mode.zsh

# Disable underline for syntax highlights
(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none

# exports
export PATH=$HOME/.cargo/bin:$PATH
export EDITOR="nano"

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# ls aliases
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'

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
PROMPT='%F{blue}%T%f %B%F{cyan}%~%f%b %F{#FFA500}${vcs_info_msg_0_}%f${NEWLINE}%B%F{green}❯%f%b '
