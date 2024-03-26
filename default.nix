{ pkgs ? import <nixpkgs> {},
  lib ? pkgs.lib }:

{
  icons = pkgs.stdenv.mkDerivation {
    name = "nix-icons";
    srcs = lib.cleanSource ./.;
    buildInputs = with pkgs; [ imagemagick xmlstarlet ];
    makeFlags = [ "DESTDIR=$(out)" "prefix=" ];
  };
}
