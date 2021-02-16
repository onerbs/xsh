# Copyright (c) 2021 Alejandro Elí. All rights reserved.
# This file is subject to the terms and conditions defined in
# the LICENSE file, which is part of this source code package.

not EXPS1 && export EXPS1="$PS1"

psc () {
  #! Manage the PS1 color
  #+ [COLOR]
  #- COLOR must be a number in the form 3?[0-7]
  #- Any other argument will be ignored.
  case $1 in
    3[0-7] ) export PSC=$1 ;;
     [0-7] ) export PSC=$1 ; (( PSC+=30 )) ;;
    * ) # COLOR: Set the CWD color to COLOR
      ;;
  esac
}

psy () {
  #! Manage the PS1 symbol
  #+ [-q | SYMBOL]
  #- The symbol may contains leading spaces.
  #: ' % '
  #- If you happen to be inside a git directory, the symbol
  #- will be resolved to the name of the current branch.
  var ExitCode=$?
  case $1 in
    -q ) # Unset the symbol
      unset PSY
      unset PSY_BAK
      ;;
    '' ) # Print the current symbol
      GB=$(git branch --show-current 2> /dev/null) && \
      PSY=" ($GB)" || PSY="$PSY_BAK"
      echo "$PSY"
      ;;
    * ) # SYMBOL: Set the symbol to SYMBOL
      PSY="$1"
      PSY_BAK="$1"
      ;;
  esac
  return $ExitCode
}

psu () {
  #! Manage the `psu` module
  #+ [-Q]
  var ExitCode=$?
  case $1 in
    -Q ) # Unset all functions and variables of this lib
      PS1="$EXPS1"
      unset -v PSC PSY PSU PSR PSY_BAK EXPS1
      unset -f psc psy psu psu::status
      ;;
    '' ) # Print the current working directory
      echo -n "$PWD"
      ;;
  esac
  return $ExitCode
}

psu::status () {
  int ExitCode=$?
  (( ExitCode )) && echo -n " $ExitCode"
}

psc "${PSC:-7}"
psy "${PSY:-:}"

PSU='\[\e[${PSC}m\]$(psu)\[\e[m\]$(psy)'
PSR='\[\e[31m\]$(psu::status)\[\e[m\] '
PS1="$PSU$PSR"
