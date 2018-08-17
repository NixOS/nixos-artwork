NixOS Logo
==========

This is the canonical location of the NixOS logo, affectionately called the
*Nix Snowflake*.

Technicalities
--------------

### Font

A logo with the baked-in outline is made available and is recognized as the
*de-facto* version of the logo, since the font's exact revision, for its
metrics and the software used to produce the outlines is unknown. Using a
recent revision of the font with a recent inkscape produces different outlines.

The font used is *[Vegur](http://dotcolon.net/font/vegur/)*, a CC0 font.
The revision used is one of the harder to find revisions, either 0.601 or [0.602](https://web.archive.org/web/20120828195558/http://www.dotcolon.net:80/font/?id=vegur).

Do note that the original logo as designed has manually positioned O and S, and
a manually transformed O shape.

The manual adjustments have been faithfully re-created over the existing
de-facto version of the logo in `nixos.text.svg` if it can be useful. The main
idea behind the adjustments seems to keep the round letters narrower (letters
like O and C). The file has been built expecting the **Vegur602** font family
instead of the *Vegur* font family. Such a font family can be built using the
derivation and source files provided in the font folder.

### Using the logo

The svg source files have a *logo-guide* and those with text a *guide* layer.
Ensure the snowflake has at least the given margin with any other elements with
other elements when used. The source SVG files with text already have the
margin baked into the files.

License
-------

The logo is made available under a [CC-BY license](https://creativecommons.org/licenses/by/4.0/).

 * [Nix-dev mailing list, Sun Oct 2 08:49:55 CEST 2016](https://nixos.org/nix-dev/2016-October/021876.html)
