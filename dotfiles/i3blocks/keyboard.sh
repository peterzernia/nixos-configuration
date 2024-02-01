#!/usr/bin/env sh

layout=$(setxkbmap -query | awk '/layout/{print $2}')

echo "$layout"
