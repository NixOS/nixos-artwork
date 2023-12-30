with import <nixpkgs> {};
mkShell {
  nativeBuildInputs = [ grub2_efi inkscape imagemagick ];
  dejavu = dejavu_fonts;
  __strictDeps = true;
}
