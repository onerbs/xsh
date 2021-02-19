# Copyright (c) 2021 Alejandro Elí. All rights reserved.
# This file is subject to the terms and conditions defined in
# the LICENSE file, which is part of this source code package.

alias var='declare'
alias val='var -xr'
alias int='var -i'
alias map='var -A'
alias vec='var -a'

eqs () {
  #! Check if STR_A is the same as STR_B
  #+ STR_A STR_B
  #- The string ' a' is considered different to 'a'
  case "$1" in "$2") ;; * ) false ;; esac
}

eqx () {
  #! Check if STRING match PATTERN
  #+ STRING PATTERN
  #: $PATH '*:*'
  case "$1" in  $2 ) ;; * ) false ;; esac
}

issu () {
  #! Check if the active user is root
  #: || deny_access
  (( ! $(id -u) ))
}

isw () {
  #! Check if INPUT is an empty or blank string
  #+ [INPUT]
  var Input="$*"
  case $Input in
    - ) # Read INPUT from the standard input
      Input=$(cat -)
      ;;
  esac
  [ ! $Input ]
}

quiet () {
  #! Run COMMAND without printing any output
  #+ COMMAND
  $@ &> /dev/null
}

not () {
  #! Return true if the VARIABLE value is blank or undefined
  #+ VARIABLE
  #: variable && declare variable=value
  isw $1 && return 2
  quiet declare -p $1 || return 0
  isw $(declare -p $1 2> /dev/null | cut -d\" -f2)
}
