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

_CHBIN_HOME="$HOME/.shbin"

echo -e "$(color $_bold $_fg$_red $_bg$_yellow)WELCOME TO SHBIN!$(color)"
echo ""

echo "TEST JAVA: "
if which "java"; then echo -e "$done"
else
  echo "ERROR: NO JRE FOUND"
  exit 3
fi

echo "Check if SHBIN is already installed..."
if [ -d $_CHBIN_HOME ]; then
  echo -e "$(color $_bold $_fg$_red)Found $_CHBIN_HOME dir...$(color)"
  exit 1
fi

echo "No old installation found."
echo ""

echo "Creating SHBIN home dir"
if ! mkdir -p "$_CHBIN_HOME"; then
  echo -e "$(color $_bold $_fg$_red)ERROR CREATING SHBIN HOME$(color)"
  exit 2
fi

cd "$_CHBIN_HOME"

echo "Creating init script..."
cat >.init.sh <<EOF
SHBIN_HOME="\$HOME/.shbin"
PATH=\$PATH:"\$SHBIN_HOME"/bin
export PATH
export SHBIN_HOME
EOF

if [[ -s .init.sh ]]; then
  echo -e "$done"
fi

cd "$HOME"

echo "Creating a backup copy of .bashrc"
cp -f .bashrc .bashrc.bak.0 && echo -e "$done"

echo "Configuring .bashrc..."
echo '' >>.bashrc
echo '#SHBIN INIT' >>.bashrc
echo "[[ -s \"$HOME/.shbin/.init.sh\" ]] && source \"$HOME/.shbin/.init.sh\"" >>.bashrc
echo '' >>.bashrc
echo -e "$done"

source ".bashrc"

echo "Download manager..."
cd $_CHBIN_HOME
wget "http://minegrado.ovh/shbin/shbin.tar.gz" -O"shbin.tar.gz" && echo -e "$done"
gzip -d "shbin.tar.gz"
tar -xf "shbin.tar"
echo ""

echo -e "$(color $_bold $_fg$_green $_bg$_blue)DONE!$(color)"

echo -e "Run '$(color $_italic)source .bashrc$(color)' or simply open a new TTY to use shbin"

exit 0
