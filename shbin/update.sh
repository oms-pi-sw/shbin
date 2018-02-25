#!/usr/bin/env bash

#escape chars
_esc="\e"

_csi="["
_sgr="m"

_fg=3
_bg=4
_black=0
_red=1
_green=2
_yellow=3
_blue=4
_magenta=5
_cyan=6
_white=7

_bold=1
_italic=3
_underl=4
_reverse=7

color() {
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

done="$(color $_bold $_fg$_green)DONE$(color)"

if [ "$SHBIN_HOME" = "" ]; then
  echo -e "NO shbin FOUND!"
  exit 1
fi

cd "$SHBIN_HOME"
update_dir=".shbin_update_tmp"
mkdir "$update_dir"

echo "Copying installed packages dict..."
installed="installed-packages"
if cp -f "./etc/$installed" "./$update_dir/"; then
  echo -e "$done"
else
  echo "ERROR"
  exit 2
fi

echo "Download manager..."
wget "http://minegrado.ovh/shbin/shbin.tar.gz" -O"shbin.tar.gz" && echo -e "$done"
gzip -dvf "shbin.tar.gz"
tar -xf "shbin.tar"
echo ""

echo "Restoring installed packages backup..."
if cp -f "./$update_dir/$installed" "./etc"; then
  echo -e "$done"
else
  echo "FATAL ERROR... shbin installation may be compromized."
  exit 3
fi

rm "shbin.tar"

echo -e "Run:\n\n\t'$(color $_italic)source .bashrc$(color)'\n\nor simply open a new TTY to use shbin"

exit 0
