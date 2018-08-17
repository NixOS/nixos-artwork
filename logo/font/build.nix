{ pkgs ? import <nixpkgs> {} }:

{
  vegur602 = pkgs.callPackage ./602.nix {};
}
