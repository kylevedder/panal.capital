# Panal Capital Design Journey

This archive preserves the image-model prototypes, vector iterations, and final design decisions for the Panal Capital landing page.

## Prototype Boards

- `01-horse-prototypes/horse-prototype-board-01.png`: four diffusion-generated jumping horse line-mark directions. The final mark follows the calmer lower-right/top-right profile language, while reducing mane/detail and normalizing stroke weight.
- `02-wordmark-prototypes/wordmark-prototype-board-01.png`: calligraphic wordmark explorations. The final wordmark keeps the restrained script posture and avoids the all-caps and overly ornamental options.
- `03-layout-prototypes/layout-prototype-board-01.png`: composition studies. The final page uses a centered vertical stack with wide negative space and no footer, navigation, or decorative frame.

## Vector Iterations

- `04-vector-iterations/horse-mark-v1.svg`: first simplified horse trace, focused on silhouette and pose.
- `04-vector-iterations/horse-mark-v2.svg`: refined production direction with smoother body curves, tucked forelegs, extended hind legs, and reduced detail.
- `04-vector-iterations/horse-mark-v3.svg`: an additional cleaner-symbol pass that was rejected because it lost too much equine anatomy at page scale.
- `04-vector-iterations/subagent-55/`: parallel gpt-5.5 SVG pass. Its horse candidate was promoted into production after comparison because it had the clearest jumping-horse read.
- `04-vector-iterations/wordmark-v1.svg`: early live-text script direction.
- `04-vector-iterations/wordmark-v2.svg`: tuned live-text direction used to assess balance and spacing.
- `04-vector-iterations/wordmark-outlined-v3.svg`: outlined wordmark generated from a local calligraphic font so the production asset renders consistently.
- `04-vector-iterations/final-lockup.svg`: composition reference for the production page.

## Final Assets

- `../assets/horse-mark-fit.svg`: current production horse, a hard-edge single-path spline reconstruction of the diffusion prototype.
- `../assets/panal-capital-wordmark-fit.svg`: current production wordmark, a hard-edge single-path spline reconstruction of the diffusion prototype.
- `../assets/prototype-crops/*.png`: preserved diffusion PNG targets used for fitting and visual comparison.
- `../assets/horse-mark.svg` and `../assets/panal-capital-wordmark.svg`: retained as earlier vector attempts/reference, not currently used by the live page.

The visible production page now uses low-complexity hard-edge SVG reconstructions rather than PNG assets. The fitting artifacts and rejected overfit attempts are preserved under `05-svg-fitting/`.
