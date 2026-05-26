# Horse Mark Fitting Notes

Target changed on 2026-05-25: optimize for a clean hard-edged filled spline silhouette with normal SVG/browser antialiasing only. The diffusion PNG is used as the shape source, not as a soft-alpha target.

## Iterations

- `iteration-01.svg`: provided baseline from `design-journey/05-svg-fitting/baseline/search/horse-t55-o0.02.svg`; one compound path.
- `iteration-02.svg`: threshold 0.55, `alphamax=1.0`, `opttolerance=0.05`.
- `iteration-03.svg`: threshold 0.55, `alphamax=1.0`, `opttolerance=0.10`.
- `iteration-04.svg`: threshold 0.55, `alphamax=1.0`, `opttolerance=0.20`.
- `iteration-05.svg`: threshold 0.55, `turdsize=3`, `alphamax=1.5`, `opttolerance=0.05`; selected visual base.
- `iteration-06.svg`: threshold 0.56, `turdsize=3`, `alphamax=1.5`, `opttolerance=0.05`.
- `iteration-07.svg`: threshold 0.54, `turdsize=3`, `alphamax=1.5`, `opttolerance=0.05`.
- `iteration-08.svg` through `iteration-14.svg`: more aggressive smoothing checks around `alphamax=2.0-3.0` and `opttolerance=0.10-0.60`; these did not improve the visual tradeoff.
- `iteration-15.svg`: normalized final wrapper for `iteration-05.svg`; removes generated metadata/doctype while preserving the selected geometry.

## Selection

`iteration-15.svg` is the final candidate and was copied to `assets/horse-mark-fit.svg`.

Final verifier output:

```json
{"target":"assets/prototype-crops/horse-mark-diffusion.png","candidate":"design-journey/05-svg-fitting/horse/iteration-15.svg","width":600,"height":430,"shape_count":1,"alpha_rmse":0.039688,"render":"design-journey/05-svg-fitting/horse/iteration-15-render.png","diff":"design-journey/05-svg-fitting/horse/iteration-15-diff.png"}
```

The lower RMSE baseline (`iteration-01.svg`, `0.0390364`) retained slightly more traced edge detail. The selected final has the same visible anatomy at page scale, a cleaner hard silhouette, one compound path, and 21 explicit path commands in the path data. Remaining visual differences are hard-edge residuals against the soft-alpha PNG and tiny contour regularization at the mane, face, belly line, and tail.

No raster embeds, alpha bands, blur filters, or layered opacity tricks are used.
