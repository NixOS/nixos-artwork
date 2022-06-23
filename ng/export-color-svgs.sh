TEMPDIR=$(mktemp -d)
INPUT_CSG='nix.scad'
PARAMFILE='nix.json'

function export_svg() {
COLORS=$(
    openscad -p "${PARAMFILE}" -P "${PROFILE}" "$INPUT_CSG" -o "${TEMPDIR}/no_color.svg" -D "module color(c) {echo(mowmow = str(c));}" 2>&1 |
    grep -Po '(?<=(mowmow = \"))(#[0-9a-fA-F]{6}|[0-9a-fA-F]{8})' |
    sort -u
);

SVGFILE=out/${PROFILE}.svg

{
cat <<EOF
<?xml version="1.0" standalone="no"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
<svg width="0mm" height="0mm" xmlns="http://www.w3.org/2000/svg" version="1.1">
<title>${PROFILE}</title>
EOF
for color in $COLORS; do
    openscad -p "${PARAMFILE}" -P "${PROFILE}" "$INPUT_CSG" --export-format svg -o - -D "module color(c) {if (c == \"${color}\") children();}" 2>/dev/null|
    sed "s/stroke=\"black\"//g" |
    sed "s/stroke-width=\"0.5\"//g" |
    sed "s/lightgray/${color}/g" |
    grep -Pzo '<path(\n|\N)*/>' |
    # drop the Null
    head -c-1
    echo
done
cat <<EOF

</svg>
EOF

} > ${SVGFILE}
inkscape --actions="file-open:${SVGFILE};select-all;fit-canvas-to-selection;export-filename:${SVGFILE};export-do;file-close"
}

for profile in nix nix-grid nix-gapless; do
    export PROFILE=$profile
    export_svg
done
