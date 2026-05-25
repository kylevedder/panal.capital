# Subagent 55 Vector Notes

## Selected directions

- Horse: selected the cleaner full-profile jumping horse from the right-side prototype directions, especially the flowing mane and extended body posture. Rejected the denser layout-board horse because the extra interior hatching felt illustrative instead of brand-mark clean.
- Wordmark: selected the elegant script direction from the wordmark board, but restrained the weight, spacing, and decoration so the mark can sit with the monoline horse.
- Lockup: selected the right-column layout idea from the layout board: horse above, fine divider, stacked wordmark, then centered blurb.

## Iteration changes

- `horse-mark-v1.svg`: first handmade vector pass with fuller mane/tail detail and a slightly heavier contour.
- `horse-mark-v2.svg`: production candidate with cleaner proportions, calmer curve transitions, reduced stroke weight, a more balanced neck/head shape, and one subtle interior belly detail. It remains pure stroked paths with no fills or raster embeds.
- `wordmark-v1.svg`: horizontal text-based wordmark for a wider masthead use case.
- `wordmark-v2.svg`: stacked text-based wordmark for the landing lockup direction, with a small baseline flourish.

## Caveats

- The wordmarks use SVG text with a restrained system-font stack headed by `Snell Roundhand`. This avoids raster embeds, but exact letterforms depend on the installed font environment unless later converted to outlines.
- `final-lockup.svg` includes a dark green background only as a design-reference composition. The standalone production horse and wordmark candidates remain transparent.
