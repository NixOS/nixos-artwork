{ runCommand
, lib
, inkscape
, nodePackages
}:

runCommand "nixos-artwork-logos" {
  logos = [
    # The snowflake-only variants
    "nix-snowflake-colours"
    "nix-snowflake-white"

    # The horizontal variants
    "nixos"
    "nixos-white"

    # The vertical variant
    "nixos-text-below"
  ];
  src = lib.cleanSource ./.;
  nativeBuildInputs = [
    inkscape
    nodePackages.svgo
  ];
} ''
  PS4=" $ "
  for f in $logos; do
    mkdir -p $out
    printf ":: ⇒ %s\n" "$f"
    (set -x
    inkscape --export-background-opacity=0 --export-plain-svg --export-filename=$out/$f.svg "$src/$f.svg"
    inkscape --export-background-opacity=0 --export-filename=$out/$f.png "$src/$f.svg"
    )
  done
  (set -x
  svgo --pretty --multipass --folder "$out"
  )
''
