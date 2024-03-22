# files and navigation
alias rm_safe='rm -r'
alias rm_forever='rm -rf'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'
# Some personal aliases
# start applications
alias mlflowstart='cd mlflow && mlflow server --backend-store-uri sqlite:///mlflow.db --default-artifact-root mlflow-artifacts --host 0.0.0.0'
alias pycharm='/home/mn-man.biz/ar408/.local/pycharm-2023.3.5/bin/pycharm.sh'
alias IJ='/home/mn-man.biz/ar408/.local/ideaC/bin/idea.sh'
# navigate to current repos
alias repos='cd ~/repos'
alias preds='cd ~/repos/prediction_tests'
alias decaf='cd ~/repos/decaf'
alias cpnotebook='cd ~/repos/cp-occupation-dataset-notebook'
alias selenium='cd ~/repos/python-selenium-scraper'
alias forecast='cd ~/repos/forecastexperiments'
# execute bash scripts
alias gen_ssh='bash ~/repos/utils/gen_ssh.sh'
alias decompress='bash ~/repos/utils/decompress.sh'
alias createrepo='bash ~/repos/utils/create_repo.sh'
alias memory='bash ~/repos/utils/memory.sh'
# Net
alias port='netstat -tulanp'
#git config for dotfiles
alias config='/usr/bin/git --git-dir=/home/mn-man.biz/ar408/.cfg/ --work-tree=/home/mn-man.biz/ar408'
