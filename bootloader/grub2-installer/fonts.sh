#!/usr/bin/env nix-shell
#!nix-shell -p grub2_efi -p dejavu_fonts -i bash

# This script can be used to (dirtily) build fonts for grub2.
# This script assumes only DejaVu, and only one size.

set -e
set -u
PS4=" $ "
set -x

DEJA=

for p in $buildInputs; do
	DEJA="$p"
done

grub-mkfont -s 20 "$DEJA/share/fonts/truetype/DejaVuSans.ttf" -o dejavu.pf2
