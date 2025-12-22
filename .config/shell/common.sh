export EDITOR="nvim"
export VISUAL="nvim"

# Local bins
[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"
[ -d "$HOME/.yarn/bin" ] && PATH="$PATH:$HOME/.yarn/bin"

export PATH

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias getitdone='cd "$HOME/Documents/work"'
alias coding-lab='cd ~/.repos/research'

#Git helpers
unalias gp 2>/dev/null || true
unalias gcb 2>/dev/null || true
unalias gs 2>/dev/null || true
unalias gac 2>/dev/null || true

alias gs='git status'
gac() { git add "$1" && git commit -m "$2"; }
gp()  { git push "$@"; }
gcb() { git checkout "$1"; }

# Others
alias delpy='find . -type d -name "__pycache__" -exec rm -r {} +'

# Dotfiles bare repo
alias config='/usr/bin/git --git-dir="$HOME/.cfg/" --work-tree="$HOME"'

# Start Ups
alias mlflowstart='cd mlflow && mlflow server --backend-store-uri sqlite:///mlflow.db --default-artifact-root mlflow-artifacts --host 0.0.0.0'
alias pycharm='nohup "$HOME/.local/pycharm-2023.3.5/bin/pycharm.sh" &> /dev/null &'
alias IJ='nohup "$HOME/.local/ideaC/bin/idea.sh" &> /dev/null &'

# Util scripts
alias gen_ssh='bash "$HOME/repos/utils/gen_ssh.sh"'
alias decompress='bash "$HOME/repos/utils/decompress.sh"'
alias createrepo='bash "$HOME/repos/utils/create_repo.sh"'
alias memory='bash "$HOME/repos/utils/memory.sh"'
alias set_node='bash "$HOME/repos/utils/set_nv.sh"'
