#!/usr/bin/env sh

variant=$(setxkbmap -query | awk '/variant/{print $2}')

if [ -z "$variant" ]; then
  layout=$(setxkbmap -query | awk '/layout/{print $2}')
  echo "$layout"
else
  echo "$variant"
fi

