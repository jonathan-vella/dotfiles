# ~/.bashrc — interactive bash config

# Exit if not interactive
[[ $- != *i* ]] && return

# --- History ---
HISTSIZE=10000
HISTFILESIZE=20000
HISTCONTROL=ignoredups:erasedups
shopt -s histappend

# --- Shell options ---
shopt -s checkwinsize
shopt -s cdspell

# --- Prompt ---
PS1='\[\e[1;32m\]\u@\h\[\e[0m\]:\[\e[1;34m\]\w\[\e[0m\]\$ '

# --- Aliases ---
alias ll='ls -lAh --color=auto'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias grep='grep --color=auto'
alias diff='diff --color'
alias mkdir='mkdir -pv'
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'

# --- Functions ---
mkcd() { mkdir -p "$1" && cd "$1"; }

# --- Load local overrides ---
[ -f "$HOME/.bashrc.local" ] && source "$HOME/.bashrc.local"
