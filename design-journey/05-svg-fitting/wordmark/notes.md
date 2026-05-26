# Panal Capital Wordmark Fitting Notes

## Current target

- Use `assets/prototype-crops/panal-capital-wordmark-diffusion.png` as the shape source only.
- Prefer a clean hard-edge calligraphic SVG silhouette with normal browser antialiasing.
- Do not optimize for matching the PNG's soft alpha fringe, and do not use blur filters, alpha bands, raster embeds, or dense high-resolution traces.

## Iterations

- `iteration-100.svg`: copied from the provided strong baseline `design-journey/05-svg-fitting/baseline/search/wordmark-t42-o0.02.svg`, with metadata removed and ivory fill retained. This measured `alpha_rmse=0.0530772` against the soft target alpha, but that metric is diagnostic only under the hard-edge target.
- `iteration-101.svg` through `iteration-196.svg`: regularized threshold/alphamax/opttolerance sweep. These variants were smoother in some local details but used more path commands or lost letterform fidelity, and none beat the baseline visually or diagnostically.
- `iteration-197.svg`: cleaned final candidate from `iteration-100.svg`. It keeps the same silhouette and verifier score, but removes Potrace boilerplate and uses a minimal accessible SVG wrapper.
- `refinement-2026-05-25/`: follow-up sweep after visual feedback that `iteration-197.svg` was slightly overregularized. The selected `wordmark-t46-o0.001.svg` keeps a more faithful contour while remaining a single compound spline path.

## Final choice

`refinement-2026-05-25/wordmark-selected-higher-fidelity.svg` is the selected asset and was copied to `assets/panal-capital-wordmark-fit.svg`.

Reference metrics for the selected refinement:

- Verifier alpha RMSE: `0.0528465` against the soft-edged PNG.
- Shape count: `1`.
- Canvas and render placement: `980x190`, alpha bounding box `844x165+85+25`.

## Visual caveats

The final is intentionally a clean, hard-edge reconstruction. It will not reproduce the diffusion PNG's soft transparent edge pixels exactly; the remaining verifier diff is mostly the expected red/blue fringe from comparing normal SVG antialiasing against the PNG's alpha fringe. Letterform proportions, counters, endpoints, and placement match the source at page scale.
