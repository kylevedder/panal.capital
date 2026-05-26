#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 4 ]]; then
  echo "usage: $0 <target.png> <candidate.svg> <width> <height>" >&2
  exit 2
fi

target="$1"
candidate="$2"
width="$3"
height="$4"

if grep -Eiq '<image|base64|data:image' "$candidate"; then
  echo "ERROR: candidate contains raster embed or data URI" >&2
  exit 3
fi

shape_count="$(grep -Eoi '<(path|circle|ellipse|rect|line|polyline|polygon)\b' "$candidate" | wc -l | tr -d ' ')"
if [[ "$shape_count" -gt 800 ]]; then
  echo "ERROR: candidate has $shape_count vector shapes; likely degenerate" >&2
  exit 4
fi

out_dir="$(dirname "$candidate")"
base="$(basename "$candidate" .svg)"
render="$out_dir/$base-render.png"
diff="$out_dir/$base-diff.png"
target_alpha="$out_dir/$base-target-alpha.png"
render_alpha="$out_dir/$base-render-alpha.png"
target_comp="$out_dir/$base-target-comp.png"
render_comp="$out_dir/$base-render-comp.png"
alpha_delta="$out_dir/$base-alpha-delta.png"
target_label="$out_dir/$base-target-label.png"
render_label="$out_dir/$base-render-label.png"
diff_label="$out_dir/$base-diff-label.png"

rsvg-convert -w "$width" -h "$height" "$candidate" -o "$render"

magick "$target" -alpha extract "$target_alpha"
magick "$render" -alpha extract "$render_alpha"

rmse_raw="$(
  compare -metric RMSE "$target_alpha" "$render_alpha" null: 2>&1 >/dev/null || true
)"
rmse_norm="$(printf '%s\n' "$rmse_raw" | awk -F'[()]' '{print $2}')"

magick "$target" -background '#0c1a14' -alpha background -alpha off "$target_comp"
magick "$render" -background '#0c1a14' -alpha background -alpha off "$render_comp"

magick "$render_alpha" "$target_alpha" -compose minus_src -composite "$out_dir/$base-extra.png"
magick "$target_alpha" "$render_alpha" -compose minus_src -composite "$out_dir/$base-missing.png"
magick -size "${width}x${height}" xc:black \
  "$out_dir/$base-extra.png" -channel R -compose copy -composite \
  "$out_dir/$base-missing.png" -channel B -compose copy -composite \
  -channel G -evaluate set 0 +channel "$alpha_delta"

make_label() {
  local text="$1"
  local out="$2"
  magick -size "${width}x32" xc:'#0c1a14' \
    -gravity center -fill '#f1ead8' -font Helvetica -pointsize 18 \
    -annotate +0+0 "$text" "$out"
}

make_label "target" "$target_label"
make_label "render" "$render_label"
make_label "diff: red=extra blue=missing" "$diff_label"

magick "$target_label" "$target_comp" "$render_label" "$render_comp" "$diff_label" "$alpha_delta" -append "$diff"

rm -f "$out_dir/$base-extra.png" "$out_dir/$base-missing.png" "$target_label" "$render_label" "$diff_label"

printf '{"target":"%s","candidate":"%s","width":%s,"height":%s,"shape_count":%s,"alpha_rmse":%s,"render":"%s","diff":"%s"}\n' \
  "$target" "$candidate" "$width" "$height" "$shape_count" "$rmse_norm" "$render" "$diff"
