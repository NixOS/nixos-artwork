{stdenv, python36Packages, unzip}:

stdenv.mkDerivation rec {
  name = "vegur602-${version}";
  version = "0.602";

  src = ./vegur.602.zip;

  unpackPhase = ''
    unzip $src
  '';

  nativeBuildInputs = [ unzip python36Packages.fonttools ];

  patchPhase = ''
    ttx *.otf
    rm *.otf
    for f in *.ttx; do
      substituteInPlace "$f" \
        --replace 'Vegur' 'Vegur602' \
        --replace 'vegur' 'vegur602'
      ttx "$f"
    done
  '';

  installPhase = ''
    mkdir -p $out/share/fonts/vegur602
    for f in *.otf; do
      mv "$f" "$out/share/fonts/vegur602/"
    done
  '';

  meta = with stdenv.lib; {
    homepage = http://dotcolon.net/font/vegur/;
    description = "A humanist sans serif font.";
    platforms = platforms.all;
    maintainers = [ maintainers.samueldr ];
    license = licenses.cc0;
  };
}
