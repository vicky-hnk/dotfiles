# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Source .bashrc if it exists
if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

# Source .bash_aliases if it exists
if [ -f ~/.bash_aliases ]; then
  source ~/.bash_aliases
fi

# Path to your Oh My Zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Optimize Zsh completion initialization
autoload -Uz compinit
if [[ -n "$ZDOTDIR" ]]; then
  compinit -d "$ZDOTDIR/.zcompdump"
else
  compinit -d "$HOME/.zcompdump"
fi

# Set theme
ZSH_THEME="robbyrussell"

# Enable useful plugins
plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-completions)

# Enable directory auto-completion for `cd`
zstyle ':completion:*' menu select

# Load Oh My Zsh **before custom bindings**
source $ZSH/oh-my-zsh.sh

# 🔹 Unbind keybindings for hjkl navigation
bindkey -r "^[h"  # Unbind Alt+h
bindkey -r "^[j"  # Unbind Alt+j
bindkey -r "^[k"  # Unbind Alt+k
bindkey -r "^[l"  # Unbind Alt+l
bindkey -r "^H"   # Unbind Ctrl+H (backward-delete-char)
bindkey -r "^[H"  # Unbind Alt+H (run-help)

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment to make `_` and `-` interchangeable in completions.
# HYPHEN_INSENSITIVE="true"

# Uncomment to disable Oh My Zsh auto-update.
# zstyle ':omz:update' mode disabled

# Uncomment to change the auto-update frequency (default: 13 days).
# zstyle ':omz:update' frequency 13

# Uncomment if pasting URLs breaks behavior.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment to disable colors in `ls`
# DISABLE_LS_COLORS="true"

# Uncomment to disable setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment to show dots when waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment to disable slow repository status checks.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment to change command history timestamp format.
# HIST_STAMPS="yyyy-mm-dd"

# Custom User Configuration

# export MANPATH="/usr/local/man:$MANPATH"

# Set language environment (if needed)
# export LANG=en_US.UTF-8

# Preferred editor setup
export EDITOR='nvim'

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# 🔹 Better alias definitions
alias zshconfig="$EDITOR ~/.zshrc"
alias ohmyzsh="$EDITOR ~/.oh-my-zsh"

# Reload shell config without restarting terminal
alias reload="source ~/.zshrc"

[ -f "/home/vicky/.ghcup/env" ] && . "/home/vicky/.ghcup/env" # ghcup-env