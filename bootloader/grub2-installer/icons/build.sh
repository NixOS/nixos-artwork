#!/usr/bin/env nix-shell
#!nix-shell -p inkscape -p bash -i bash

# Use this to pre-build the png icons using the source files.

set -e
set -u
PS4=" $ "
set -x

for f in *.svg; do
	inkscape -e "${f%.*}.png" "$f"
done
