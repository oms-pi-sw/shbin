#!/usr/bin/env bash

updatepbar() {
  cols=$(tput cols)
  prg=$1
  dne=`expr $prg '*' $cols '/' 100`
  len=$(echo -n "$prg" | wc -c)
  half=`expr $cols '/' 2 '-' 2`
  
  out="\e8"
  out="$out""\e7"
  #echo -n -e "\e[?25l"
  _prg="$prg"%
  for i in $(seq 1 1 $cols); do
    k=`expr $i '-' 1 '-' $half`
    c=${_prg:$k:1}
    if [ "$k" -lt 0 -o "$c" = "" ]; then
      c=" "
    fi
    
    if [ $i -eq 1 ]; then
      out="$out""\e[7m"
    fi
    
    out="$out""$c"
    
    if [ $i -eq $dne -o $dne -eq 0 ]; then
      out="$out""\e[m"
    fi
    
    
  done
  echo -ne "$out"
  #echo -ne "\e[?25h"
}

progressfilt () {
    local __f=false perc="" c
    echo -ne "\e7"
    while IFS='' read -d '' -rn 1 c; do
        re='^[0-9]+$'
        if [[ "$c" =~ $re ]]; then
          perc="$perc""$c"
          __f=true
        elif [[ "$c" = '%' ]] && $__f; then
          #printf '%s%%\r' "$perc"
          updatepbar "$perc"
          #sleep 0.2
        else
          perc=""
          __f=false
        fi
    done
    echo -ne "\e7"
}

wget "http://minegrado.ovh/DWN/LPC11U24/LAST.7z" -Otmp 2>&1 | progressfilt
#curl --progress-bar "http://minegrado.ovh/DWN/LPC11U24/LAST.7z" -Otmp

exit 0
