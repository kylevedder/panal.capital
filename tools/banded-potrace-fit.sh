#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 5 || $# -gt 6 ]]; then
  echo "usage: $0 <target.png> <out.svg> <width> <height> <bands> [opttolerance]" >&2
  exit 2
fi

target="$1"
out="$2"
width="$3"
height="$4"
bands="$5"
opttolerance="${6:-0.08}"

work="$(mktemp -d)"
trap 'rm -rf "$work"' EXIT

alpha="$work/alpha.png"
magick "$target" -alpha extract "$alpha"

{
  printf '<?xml version="1.0" encoding="UTF-8"?>\n'
  printf '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 %s %s" width="%s" height="%s">\n' "$width" "$height" "$width" "$height"
  printf '  <title>Banded alpha spline reconstruction</title>\n'
} > "$out"

for ((i=0; i<bands; i++)); do
  low="$(awk -v i="$i" -v n="$bands" 'BEGIN { printf "%.10f", i / n }')"
  high="$(awk -v i="$i" -v n="$bands" 'BEGIN { printf "%.10f", (i + 1) / n }')"
  mid="$(awk -v i="$i" -v n="$bands" 'BEGIN { printf "%.8f", (i + 0.5) / n }')"
  pbm="$work/band-$i.pbm"
  svg="$work/band-$i.svg"

  if [[ "$i" -eq $((bands - 1)) ]]; then
    expr="u >= $low ? 0 : 1"
  else
    expr="(u >= $low && u < $high) ? 0 : 1"
  fi

  magick "$alpha" -fx "$expr" "$pbm"
  potrace "$pbm" -s --flat --color '#f1ead8' --alphamax 1.0 --opttolerance "$opttolerance" --turdsize 1 -o "$svg"

  if grep -q '<path ' "$svg"; then
    printf '  <g fill="#f1ead8" fill-opacity="%s" stroke="none" transform="translate(0,%s) scale(0.100000,-0.100000)">\n' "$mid" "$height" >> "$out"
    awk '
      /<path / { inpath=1 }
      inpath {
        sub(/fill="#[0-9A-Fa-f]+"/, "")
        print "    " $0
      }
      inpath && /\/>/ { inpath=0 }
    ' "$svg" >> "$out"
    printf '  </g>\n' >> "$out"
  fi
done

printf '</svg>\n' >> "$out"
