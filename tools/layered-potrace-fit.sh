#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 5 || $# -gt 6 ]]; then
  echo "usage: $0 <target.png> <out.svg> <width> <height> <layers> [opttolerance]" >&2
  exit 2
fi

target="$1"
out="$2"
width="$3"
height="$4"
layers="$5"
opttolerance="${6:-0.10}"

work="$(mktemp -d)"
trap 'rm -rf "$work"' EXIT

{
  printf '<?xml version="1.0" encoding="UTF-8"?>\n'
  printf '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 %s %s" width="%s" height="%s" fill="none">\n' "$width" "$height" "$width" "$height"
  printf '  <title>Layered spline reconstruction</title>\n'
  printf '  <g fill="#f1ead8" stroke="none">\n'
} > "$out"

for ((i=1; i<=layers; i++)); do
  threshold=$(( 256 * i / (layers + 1) ))
  percent="$(awk -v t="$threshold" 'BEGIN { printf "%.6f%%", (t / 255.0) * 100.0 }')"
  pbm="$work/layer-$i.pbm"
  svg="$work/layer-$i.svg"

  magick "$target" -alpha extract -negate -threshold "$percent" "$pbm"
  potrace "$pbm" -s --flat --color '#f1ead8' --alphamax 1.0 --opttolerance "$opttolerance" --turdsize 2 -o "$svg"

  opacity="$(awk -v n="$layers" -v i="$i" 'BEGIN { printf "%.8f", 1.0 / (n - i + 1.0) }')"
  printf '    <g opacity="%s" transform="translate(0,%s) scale(0.100000,-0.100000)">\n' "$opacity" "$height" >> "$out"
  awk '
    /<path / { inpath=1 }
    inpath {
      sub(/fill="#[0-9A-Fa-f]+"/, "")
      print "      " $0
    }
    inpath && /\/>/ { inpath=0 }
  ' "$svg" >> "$out"
  printf '    </g>\n' >> "$out"
done

{
  printf '  </g>\n'
  printf '</svg>\n'
} >> "$out"
