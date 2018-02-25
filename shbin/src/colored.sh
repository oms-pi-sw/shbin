#!/usr/bin/env bash

#escape chars
_esc="\e"

_csi="["
_sgr="m"

export _FG=3
export _BG=4
export _BLACK=0
export _RED=1
export _GREEN=2
export _YELLOW=3
export _BLUE=4
export _MAGENTA=5
export _CYAN=6
export _WHITE=7

export _BOLD=1
export _ITALIC=3
export _UNDERL=4
export _REVERSE=7

render() {
  local str="$_esc""$_csi"
  local first=true
  for v in $@; do
    local ch=";"
    if [ $first = true ]; then
      ch=""
      first=false
    fi
    str="$str""$ch""$v"
  done
  str="$str""$_sgr"
  echo "$str"
}
