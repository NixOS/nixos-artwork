{ pkgs ? import <nixpkgs> {},
  lib ? pkgs.lib }:

{
  icons = pkgs.stdenv.mkDerivation {
    name = "nix-icons";
    srcs = lib.cleanSource ./.;
    buildInputs = [ pkgs.imagemagick ];
    makeFlags = [ "DESTDIR=$(out)" "prefix=" ];
  };
}
