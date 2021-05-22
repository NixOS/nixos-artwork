# This uses a pinned Nixpkgs so the software
# used for the export (inkscape) and fonts used
# for the export stay proper.
{ pkgs ? import ./pkgs.nix {} }:

let
  FONTCONFIG_FILE = pkgs.callPackage (
    { symlinkJoin
    , writeText
    , encode-sans
  }:
  let
    mkFontsDir = fonts: symlinkJoin {
      name = "fonts-dir";
      paths = fonts;
    };

    fontsDir = mkFontsDir [
      encode-sans
    ];
  in

  writeText "fonts.conf" ''
    <?xml version='1.0'?>
    <!DOCTYPE fontconfig SYSTEM 'urn:fontconfig:fonts.dtd'>
    <fontconfig>
    <dir>${fontsDir}</dir>

    <!-- Default rendering settings -->
    <match target="pattern">
    <edit mode="append" name="hinting">
    <bool>true</bool>
    </edit>
    <edit mode="append" name="autohint">
    <bool>true</bool>
    </edit>
    <edit mode="append" name="hintstyle">
    <const>hintslight</const>
    </edit>
    <edit mode="append" name="antialias">
    <bool>true</bool>
    </edit>
    </match>


    </fontconfig>
  ''
  ) {};

  archive = pkgs.runCommandNoCC "${build.name}-archive.tar.bz2" {} ''
    cp -r --no-preserve=mode ${build} nixos-artwork-matrix-icons
    tar cvjf $out nixos-artwork-matrix-icons
  '';

  # Yes, you can callPackage something else than a path!
  build = pkgs.callPackage (

    { runCommandNoCC, inkscape, encode-sans, FONTCONFIG_FILE, ruby }:
    runCommandNoCC "nixos-artwork-matrix-icons" {
      nativeBuildInputs = [
        inkscape
        ruby
      ];
      inherit FONTCONFIG_FILE;

      passthru = {
        inherit archive;
      };
    } ''
      ruby ${./build.rb} ${./icons.src.svg}
    ''

  ) {
    inherit FONTCONFIG_FILE;
    ruby = pkgs.ruby.withPackages(p: [
      p.nokogiri
    ]);
  };
in
  build
