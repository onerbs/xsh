# Copyright (c) 2021 Alejandro Elí. All rights reserved.
# This file is subject to the terms and conditions defined in
# the LICENSE file, which is part of this source code package.

need git || return

alias ga='git add'
alias gA='git restore --staged'

alias gbr='git branch'

alias gc='git commit'

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
-s ) # Short log: Print NUMBER entries
  git shortlog -${2:-5}
  ;;
-l ) # Print NUMBER entries
  git log --oneline -${2:-5}
  ;;
-s* ) # NUMBER: Short log: Print NUMBER entries
  git shortlog -${1:2}
  ;;
-l* ) # NUMBER: Print NUMBER entries one line each
  git log --oneline -${1:2}
  ;;
-* ) # NUMBER: Print NUMBER entries one line each
  git log --oneline $1
  ;;
* ) # NUMBER: Print NUMBER entries
  git log -n ${1:-5}
  ;;
  esac
}

alias gf='git config'
alias gfg='gf --global'
alias gp='git push'
alias gll='git pull'
alias gk='git checkout'
alias gr='git remote'
alias grv='gr -v'
alias gre='git reset'
alias grm='git rm'
alias gs='git status'
alias gt='git fetch'
alias gw='git switch'

gu () {
  #! Undo N commits (REF is HEAD by default)
  #+ TIMES [REF]
  #: gu 3 master
  git reset ${2:-HEAD}~$1
}
