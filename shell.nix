{ pkgs ? import <nixpkgs> {} }:

let
  default = import ./. { inherit pkgs; };
in
pkgs.callPackage (
  { mkShell
  , dejavu_fonts
  }:
  mkShell {
    nativeBuildInputs = []
      ++ default.bootloader.nativeBuildInputs
      ++ default.icons.nativeBuildInputs
    ;
    dejavu = dejavu_fonts;
    __strictDeps = true;
  }
) {}
