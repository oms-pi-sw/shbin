#!/usr/bin/env bash

tar -cvf shbin.tar bin/ etc/ lib/ pkg/ src/ tmp/ var/
gzip -vf shbin.tar

exit 0
