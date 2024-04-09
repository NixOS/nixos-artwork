{ pkgs ? import <nixpkgs> {} }:

{
  bootloader = pkgs.callPackage (
    { stdenv
    , lib
    , grub2_efi
    }:
    stdenv.mkDerivation {
      name = "nixos-grub-installer-theme";
      srcs = lib.cleanSource ./.;
      sourceRoot = "source/bootloader";
      nativeBuildInputs = [ grub2_efi ];
      makeFlags = [ "prefix=$(out)" ];
    }
  ) {};
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
