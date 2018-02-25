#!/usr/bin/env bash

getPkgs() {
  wget http://minegrado.ovh/shbin/pkgs/pkgs.tar.gz -O"./tmp/pkgs.tar.gz" 2>&1 | progressFilter \
  && gzip -df ./tmp/pkgs.tar.gz \
  && tar -xf ./tmp/pkgs.tar -C./tmp \
  && rm ./tmp/pkgs.tar \
  && return 0
  return 1
}
