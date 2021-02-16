# Copyright (c) 2021 Alejandro Elí. All rights reserved.
# This file is subject to the terms and conditions defined in
# the LICENSE file, which is part of this source code package.

lib () {
  #! Manage XSH libs
  #+ [OPTIONS] LIB
  var Action Lib Dir
  case $1 in

-l ) # List the available libs
  for Dir in $(state); do
    xsh_scan list $Dir
  done
  return
  ;;

-e ) # Edit LIB using $VISUAL or $EDITOR
  Action=${VISUAL:-$EDITOR};
  ;;

-E ) # EDITOR: Edit LIB using EDITOR
  Action=$2
  shift 2
  ;;

-H ) # LIB [FUNC]: Print help of the specified target
  #: -H base not
  xsh_doc ${@:2};
  return
  ;;

-h ) # Print this help and exit
  xsh_doc lib lib
  return
  ;;

  esac
  for Lib in $@; do
    xsh::iter ${Action:-source} $Lib
  done
}

need () {
  #! Declare a dependency
  #+ ITEM
  #: git || return
  quiet command -v $1 || miss $1
}

miss () {
  #! Inform that there's a missing dependency
  #+ ITEM
  fail missing dependency: $1
}
