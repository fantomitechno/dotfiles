#!/bin/sh
dir="/home/fantomitechno/.config/fastfetch/logo/"

find "$dir" -maxdepth 1 -type f -print \
  | shuf -n 1
