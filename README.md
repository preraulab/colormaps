# colormaps

Perceptually-uniform and custom colormaps for MATLAB — matplotlib-family (viridis, inferno, magma, plasma), lab-built divergent/sequential maps, and curated third-party classics (cubehelix, CMRmap, pmkmp, Scientific Colour Maps).

Developed by the [Prerau Laboratory](https://prerau.bwh.harvard.edu/) at Brigham and Women's Hospital / Harvard Medical School.

## What's here

| Family | Functions |
|---|---|
| matplotlib ports (perceptually uniform) | `viridis`, `inferno`, `magma`, `plasma` |
| Lab-built divergent | `redbluemap`, `redblue_equalized`, `redbluedark`, `redbluelight`, `blueredbluemap` |
| Lab-built sequential/diverging | `hotcoolmap`, `rainbow4`, `gouldian`, `luminosity` |
| Utilities | `equalize_divcmap` (CIELAB-lightness equalization), `colorcet` (Kovesi CET colormap browser) |
| Third-party bundles | `CMRmap/`, `cubehelix/`, `pmkmp/`, `scientific_colormaps/` (Crameri) |

See [`help <function>`](https://preraulab.github.io/colormaps/) at the MATLAB prompt, or the [published API reference](https://preraulab.github.io/colormaps/), for full per-function documentation.

## Quick start

```matlab
addpath(genpath('/path/to/colormaps'));

% Use a matplotlib-family colormap
imagesc(peaks(256));
colormap(viridis());

% Or a lab divergent with lightness-matched arms
imagesc(peaks(256));
colormap(equalize_divcmap(redbluemap(256)));
colorbar;
```

## Install

```matlab
addpath(genpath('/path/to/colormaps'));
```

`genpath` is recommended so the third-party sub-folders (CMRmap, cubehelix, pmkmp, Scientific Colour Maps) are also on the path.

## Dependencies

MATLAB R2020a+. No required toolboxes.

## Citation

If you use this repository in a publication, please cite it — see [`CITATION.cff`](CITATION.cff). Where third-party colormaps are used, please also credit the original authors (see the `license.txt` inside each bundle and the references in the function headers).

## License

BSD 3-Clause for the lab-developed code. Bundled third-party colormaps carry their own licenses (typically BSD, MIT, or CC-BY) — see each sub-folder.
