# Copyright (c) 2021 Alejandro Elí. All rights reserved.
# This file is subject to the terms and conditions defined in
# the LICENSE file, which is part of this source code package.

need git || return

alias ga='git add'
alias gA='git restore --staged'

alias gbr='git branch'

gb () {
  #! Manage your branches
  #+ [OPTION] BRANCH
  case $1 in
    -g ) # Merge A with B
      # ${4:---no-ff} // gbr -f ?
      git merge ${3:-$(gb -n)} $2
      ;;
    -U ) # Unset upstream
      gbr --unset-upstream ${@:2}
      ;;
    -E ) # Edit description
      gbr --edit-description ${@:2}
      ;;
    -t ) # Detach
      gbr --detach ${@:2}
      ;;
    -n ) # Print the name of the current branch
      gbr --show-current
      ;;
    -i ) # Contains
      gbr --contains ${@:2}
      ;;
    -I ) # No contains
      gbr --no-contains ${@:2}
      ;;
    -x ) # Merged
      gbr --merged ${@:2}
      ;;
    -X ) # No merged
      gbr --no-merged ${@:2}
      ;;
    -dR ) # Delete remote
      gpo :${@:2}
      ;;
    * ) # d, D, m, M, c, C, u
      gbr $@
      ;;
  esac
}

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
