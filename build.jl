using Pkg.Artifacts
using Pkg.TOML

THEME_DIR = joinpath(@__DIR__, "theme")
BUILD_DIR = joinpath(@__DIR__, "build")
URL = "https://github.com/darsnack/flux-theme/releases/download"
ARTIFACT_TOML = joinpath(@__DIR__, "Artifacts.toml")

function build(; theme = THEME_DIR, build = BUILD_DIR, artifact_toml = ARTIFACT_TOML, url = URL)
    # Clean up prior builds.
    ispath(build) && rm(build; recursive=true, force=true)
    mkdir(build)
    # Package up theme.
    meta = TOML.parsefile(joinpath(theme, "Theme.toml"))
    theme_name, version = meta["theme"], meta["version"]
    product_hash = create_artifact() do artifact_dir
        cp(theme, artifact_dir; force=true)
    end
    archive_filename = "$theme_name-$version.tar.gz"
    download_hash = archive_artifact(product_hash, joinpath(build, archive_filename))
    remote_url = "$url/v$version/$archive_filename"
    @info "Creating:" theme_name version product_hash archive_filename download_hash remote_url

    bind_artifact!(
        artifact_toml,
        "$theme_name",
        product_hash,
        force=true,
        download_info=Tuple[(remote_url, download_hash)]
    )
end