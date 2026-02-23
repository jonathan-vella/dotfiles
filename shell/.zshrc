# ~/.zshrc — interactive zsh config

# --- History ---
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=20000
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY
setopt APPEND_HISTORY

# --- Options ---
setopt AUTO_CD
setopt CORRECT
setopt EXTENDED_GLOB

# --- Prompt ---
autoload -Uz promptinit && promptinit
prompt walters

# --- Completion ---
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# --- Aliases ---
alias ll='ls -lAh'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias grep='grep --color=auto'
alias mkdir='mkdir -pv'
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'

# --- Functions ---
mkcd() { mkdir -p "$1" && cd "$1"; }

# --- Local overrides ---
[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"
