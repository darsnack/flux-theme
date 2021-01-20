# flux-theme

A Publish.jl theme for Flux-related packages.

## Usage

Copy `Artifacts.toml` into your repository. Then in the script that generates the documentation, override the default theme to be:
```julia
Publish.Themes.default() = artifact"flux-theme"
```
When Publish.jl generates the HTML, it will call `default()` which will point it to the correct theme artifact.

## Theme editing

The theme can be customized by adjusting the files in `theme/`.

## Releasing

To release a new theme, run a Julia REPL and include `build.jl`. Then run `build()` to generate a new `Artifact.toml` as well as a release under `build/`. You can upload this release manually to Github.