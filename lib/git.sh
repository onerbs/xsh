# Copyright (c) 2021 Alejandro Elí. All rights reserved.
# This file is subject to the terms and conditions defined in
# the LICENSE file, which is part of this source code package.

need git || return

alias ga='git add'
alias gA='git restore --staged'
alias gb='git branch'
alias gc='git commit'
alias gf='git config'
alias gfg='gf --global'
alias gk='git checkout'
alias gll='git pull'
alias gp='git push'
alias gr='git remote'
alias gre='git reset'
alias grm='git rm'
alias grv='gr -v'
alias gs='git status'
alias gt='git fetch'
alias gw='git switch'

gm () {
  #! Make a commit
  #+ MESSAGE
  var Message="$*"
  gc -m "$Message"
}

gl () {
  #! Log utility
  #+ [OPTION] NUMBER
  case $1 in
    -l ) # Print NUMBER entries (oneline)
      git log --oneline -${2:-5}
      ;;
    -s ) # Print NUMBER entries (shortlog)
      git shortlog -${2:-5}
      ;;
    * ) # NUMBER: Print NUMBER entries
      git log -${1:-5}
      ;;
  esac
}

gu () {
  #! Undo NUMBER commits
  #+ NUMBER [REF]
  #- REF is HEAD by default
  #: 3 dev
  git reset ${2:-HEAD}~$1
}
