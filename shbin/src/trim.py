#!/usr/bin/env python3

import sys

if __name__ == '__main__':
  args = sys.argv[1:];
  res = ""
  first = True
  for a in args:
    if not first:
      res += " "
    else:
      first = False
    res += a.strip()
  print(res)
