#!/usr/bin/env bash

name=""
link=""
version=""
desc=""

r=""

echo -n "Name: "
read -r name

echo -n "Link: "
read -r link

echo -n "Version: "
read -r version

echo -n "Description: "
read -r desc

echo ""
echo "Name: '$name'"
echo "Link: '$link'"
echo "Version: '$version'"
echo "Description: '$desc'"
echo ""

echo -n "Ok? [Y/n]: "
read -r r

if [ "$r" = "y" -o "$r" = "Y" ]; then
  cat >>pkgs <<EOF
pack
  n: $name
  l: $link
  v: $version
  d: $desc
end

EOF

cat pkgs

fi 

exit 0
