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
  #! Commit with a message
  #+ MESSAGE
  #- The message does not require to be quoted
  #: My first commit
  var Message="$*"
  gc -m "$Message"
}

gu () {
  #! Undo NUMBER commits
  #+ NUMBER [REF]
  #- REF is HEAD by default
  #: 3 dev
  git reset ${2:-HEAD}~$1
}
