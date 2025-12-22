# Only load if git + fzf exist
command -v git >/dev/null 2>&1 || return
command -v fzf >/dev/null 2>&1 || return

# Internal: preview first N lines to keep it fast
__fzf_preview_head='sed -n "1,200p"'

# gfbr: fuzzy checkout branch (local + remote)
gfbr() {
  local branch
  branch=$(
    git for-each-ref --format='%(refname:short)' refs/heads refs/remotes 2>/dev/null |
      sed 's#^origin/##' |
      awk '!seen[$0]++' |
      fzf --prompt='branch❯ ' --height=80% --border=rounded
  ) || return
  git checkout "$branch"
}

# gfco: fuzzy browse commits (preview git show)
gfco() {
  local sha
  sha=$(
    git log --date=short --pretty=format:'%C(auto)%h %ad %s %C(blue)%an%C(reset)' 2>/dev/null |
      fzf --prompt='commit❯ ' --no-sort --height=80% --border=rounded \
          --preview 'git show --color=always {1} | '"$__fzf_preview_head"
  ) || return
  git show "${sha%% *}"
}

# gfadd: fuzzy stage files from `git status` (multi-select)
gfadd() {
  local files
  files=$(
    git status --porcelain 2>/dev/null |
      sed -E 's/^.. //' |
      fzf --multi --prompt='add❯ ' --height=80% --border=rounded \
          --preview 'git diff --color=always -- {} | '"$__fzf_preview_head"
  ) || return
  print -r -- "$files" | xargs -I{} git add -- "{}"
}

# gfstash: fuzzy stash list (preview patch, apply on enter)
gfstash() {
  local line
  line=$(
    git stash list 2>/dev/null |
      fzf --prompt='stash❯ ' --height=80% --border=rounded \
          --preview 'git stash show -p --color=always {1} | '"$__fzf_preview_head"
  ) || return
  git stash apply "${line%%:*}"
}
