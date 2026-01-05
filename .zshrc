# ==============================
# Environment
# ==============================

# Preferred editor setup
export EDITOR='nvim'
export VISUAL='nvim'

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"

if [[ -d "$HOME/.local/bin" ]]; then
  export PATH="$HOME/.local/bin:$PATH"
fi

[[ -r "$HOME/.config/shell/common.sh" ]] && source "$HOME/.config/shell/common.sh"

# Prevent Oh My Zsh from asking about insecure completion dirs
export ZSH_DISABLE_COMPFIX=true

# ==============================
# OMZ
# ==============================

# Path to Oh My Zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Set theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Enable useful plugins
plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-completions)

# Load Oh My Zsh **before custom bindings**
source $ZSH/oh-my-zsh.sh

alias zshconfig="$EDITOR ~/.zshrc"
alias ohmyzsh="$EDITOR ~/.oh-my-zsh"

zstyle ':completion:*' menu select

# ==============================
# Completion & History
# ==============================

# Completion interface settings
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' verbose yes
zstyle ':completion:*' group-name ''

# Flags
setopt AUTO_LIST
setopt AUTO_MENU
setopt COMPLETE_IN_WORD
setopt ALWAYS_TO_END

# History
HISTSIZE=100000
SAVEHIST=100000
HISTFILE="$HOME/.zsh_history"

setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt EXTENDED_HISTORY


# ==============================
# Keybindings
# ==============================

# Unbind keybindings for hjkl navigation
bindkey -r "^[h"  # Unbind Alt+h
bindkey -r "^[j"  # Unbind Alt+j
bindkey -r "^[k"  # Unbind Alt+k
bindkey -r "^[l"  # Unbind Alt+l

[[ -r /usr/share/doc/fzf/examples/key-bindings.zsh ]] && source /usr/share/doc/fzf/examples/key-bindings.zsh
[[ -r /usr/share/doc/fzf/examples/completion.zsh ]] && source /usr/share/doc/fzf/examples/completion.zsh

# fzf custom keybindings
bindkey '^H' fzf-history-widget
bindkey '^F' fzf-file-widget
bindkey '^G' fzf-cd-widget


# ==============================
# Other Stuff
# ==============================

# Reload shell config without restarting terminal
alias reload="source ~/.zshrc"

# GHC
[ -f "$HOME/.ghcup/env" ] && . "$HOME/.ghcup/env" # ghcup-env

# Conda

if [[ -d "$HOME/.local/miniconda3" ]]; then
  export CONDA_HOME="$HOME/.local/miniconda3"
  export PATH="$CONDA_HOME/bin:$PATH"

  conda() {
    unfunction conda 2>/dev/null || true

    # Prefer conda.sh if present (faster + standard)
    if [[ -r "$CONDA_HOME/etc/profile.d/conda.sh" ]]; then
      source "$CONDA_HOME/etc/profile.d/conda.sh"
    else
      # Fallback to hook (works even if conda.sh isn't available)
      local __conda_setup
      __conda_setup="$("$CONDA_HOME/bin/conda" "shell.zsh" "hook" 2>/dev/null)" || true
      [[ -n "$__conda_setup" ]] && eval "$__conda_setup"
      unset __conda_setup
    fi

    conda "$@"
  }

  # (de-) activate without typing conda
  activate()   { conda activate "$@"; }
  deactivate() { conda deactivate "$@"; }
fi

# UV
eval "$(direnv hook zsh)"
eval "$(uv generate-shell-completion zsh)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Zoxide
eval "$(zoxide init zsh)"

# Git + fzf helpers
[[ -r "$HOME/.config/shell/git-fzf.zsh" ]] && source "$HOME/.config/shell/git-fzf.zsh"
