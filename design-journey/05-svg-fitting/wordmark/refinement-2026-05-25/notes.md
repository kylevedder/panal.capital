# Wordmark Refinement - 2026-05-25

Feedback: the production wordmark was slightly overregularized and showed uneven thinning/fattening from reduced geometry.

Response:
- Generated a threshold/opttolerance sweep from the diffusion crop using hard-edge Potrace splines.
- Selected `wordmark-t46-o0.001.svg` as the new production source.
- Promoted a cleaned accessible wrapper to `assets/panal-capital-wordmark-fit.svg`.

Selected metrics:
- Target: `assets/prototype-crops/panal-capital-wordmark-diffusion.png`
- Candidate: `assets/panal-capital-wordmark-fit.svg`
- Shape count: `1`
- Alpha RMSE: `0.0528465`
- SVG size: `12640` bytes

This keeps a single compound spline path, no raster embeds, and a slightly more faithful hard-edge contour than the previous `iteration-197.svg` asset.
