{ pkgs ? import <nixpkgs> {} }:

{
  icons = pkgs.callPackage (
    { stdenv
    , lib
    , inkscape
    , imagemagick
    }:
    stdenv.mkDerivation {
      name = "nixos-icons";
      srcs = lib.cleanSource ./.;
      sourceRoot = "source/icons";
      nativeBuildInputs = [ inkscape imagemagick ];
      makeFlags = [ "prefix=$(out)" ];
    }
  ) {};
}
