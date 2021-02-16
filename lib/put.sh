# Copyright (c) 2021 Alejandro Elí. All rights reserved.
# This file is subject to the terms and conditions defined in
# the LICENSE file, which is part of this source code package.

bold () {
  #! Print TEXT in bold
  #+ [-c COLOR] TEXT
  #- COLOR must be a number between 0 and 7 (inclusive)
  #: -c3 Hello, World!
  int Color=9
  case $1 in
    -c ) eqx $2 [0-7] && Color=$2;     shift 2 ;;
    -c[0-7] )            Color=${1:2}; shift ;;
  esac
  echo -e "\e[1;3${Color}m$*\e[m"
}

fail () {
  tag 1 -b fail $@ 1>&2
  false
}

fatal () {
  #! Print a fatal error message and exit
  #+ [-c CODE] MESSAGE
  #- CODE by default is 2.
  #-
  #- This function is meant to be used inside scripts, calling
  #- it outside that context will cause unwanted results.
  declare -i ExitCode=2
  declare -a Args
  while (( $# > 0 )); do
    case $1 in
      -c ) # CODE: Use a custom return code
        # todo: verify valid return code
        let ExitCode=${2:-$ExitCode}
        shift
        ;;
      * ) Args+=($1) ;;
    esac
    shift
  done
  tag 1 -b fatal ${Args[@]:-Exit($ExitCode)} 1>&2
  exit $ExitCode
}

tag () {
  #! Print TEXT along a colorized TAG
  #+ COLOR [OPTIONS] TAG TEXT
  #- COLOR must be a number between 0 and 7 or this will fail.
  #: 5 -b tag some text -> '  /1;35/tag/:  some text' @fmt
  #: 6 -S name some text -> '  /36/name/  some text' @fmt
  var Flag Mode Symbol=: Color
  case $1 in
    3[0-7] ) Color=$1 ;;
     [0-7] ) Color=3$1 ;;
         * ) return 1 ;;
  esac
  shift
  while true; do
    case $1 in
      -b ) # Print TAG in bold
        eqx "$Mode" *1* || Mode+='1;'
        ;;
      -i ) # Print TAG in italic
        eqx "$Mode" *3* || Mode+='3;'
        ;;
      -s ) # Change the symbol before TAG
        Symbol=$2; shift
        ;;
      -S ) # Print no symbol before TAG
        Symbol=""
        ;;
      -n ) # Do not print the new line an the end
        Flag=n
        ;;
      * ) break ;;
    esac
    shift
  done
  var Tag=$1; shift
  echo -${Flag}e "\e[${Mode}${Color}m$Tag\e[m$Symbol $*"
}
