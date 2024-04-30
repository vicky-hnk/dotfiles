# ==============================
# Navigation
# ==============================

alias rm_safe='rm -r'
alias rm_forever='rm -rf'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'

# ==============================
# Git
# ==============================

# add
function ga() {
        git add "$@"
}
#add and commit
function gac() {
        git add "$1"
        git commit -m "$2"
}

#get status
alias gs='git status'

#plain push
alias gp='git push'

#push with spec
function gp() {
        git push "$1" "$2"
}

#checkout branch
function gcb() {
        git checkout "$1"
}

# ==============================
# Custom Functions
# ==============================

# shortcuts for todo app
function add() {
    ~/Documents/todo_app + "$@"
}

function mod() {
    ~/Documents/todo_app mod "$@"
}

function del() {
    ~/Documents/todo_app del "$@"
}

function list() {
    ~/Documents/todo_app list "$@"
}

# ==============================
# Application start ups
# ==============================

alias mlflowstart='cd mlflow && mlflow server --backend-store-uri sqlite:///mlflow.db --default-artifact-root mlflow-artifacts --host 0.0.0.0'
alias todo='python3 ~/repos/task-bash/src/gui.py'
alias pycharm='/home/mn-man.biz/ar408/.local/pycharm-2023.3.5/bin/pycharm.sh'
alias IJ='/home/mn-man.biz/ar408/.local/ideaC/bin/idea.sh'
alias dbstart='cd ~/repos/phd-data && docker-compose up -d'

# ==============================
# Repository navigation
# ==============================

alias repos='cd ~/repos'
alias preds='cd ~/repos/prediction_tests'
alias decaf='cd ~/repos/decaf'
alias cpnotebook='cd ~/repos/cp-occupation-dataset-notebook'
alias selenium='cd ~/repos/python-selenium-scraper'
alias forecast='cd ~/repos/forecastexperiments'


# ==============================
# Execute util-scripts
# ==============================

alias gen_ssh='bash ~/repos/utils/gen_ssh.sh'
alias decompress='bash ~/repos/utils/decompress.sh'
alias createrepo='bash ~/repos/utils/create_repo.sh'
alias memory='bash ~/repos/utils/memory.sh'
alias set_node='bash ~/repos/utils/set_nv.sh'

# ==============================
# Network
# ==============================
# netstat not installed though
# alias port='netstat -tulanp'

# ==============================
# git config for dotfiles
# ==============================

alias config='/usr/bin/git --git-dir=/home/mn-man.biz/ar408/.cfg/ --work-tree=/home/mn-man.biz/ar408'

# ==============================
# Custom shell Functions
# ==============================

find_todos() {
  local repo_path=${1:-$(pwd)}
  local output_file="open-todos.md"
  if [[ -z "$repo_path" ]]; then
    echo "Usage: find_todos <path_to_repository> [output_file]"
    return 1
  fi

  egrep -r "^(//|/\*|#|<!--) Todo" "$repo_path" > "$output_file"
    echo "Todos have been written to $output_file"
}

alias get-todos='find_todos'

