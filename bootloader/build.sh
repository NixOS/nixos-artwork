#!/usr/bin/env nix-shell
#!nix-shell -p inkscape -p bash -i bash

set -e
set -u
PS4=" $ "
set -x

for f in refind/*.svg refind/*/*.svg; do
	inkscape -e "${f%.*}.png" "$f"
done
