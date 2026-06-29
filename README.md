# oci-python

A minimal OCI image that packages Python 3.11, 3.12, 3.13, and 3.14 (via [uv](https://github.com/astral-sh/uv)) for use in devcontainer builds.

## What it does

The `Containerfile` uses uv to install pinned releases of Python 3.12, 3.13, and 3.14 and produces a scratch-based image containing only the Python runtimes and tooling. This keeps the image as small as possible with no runtime dependencies.

The image is built for `linux/amd64` and `linux/arm64` via GitHub Actions and published to the GitHub Container Registry at:

```
ghcr.io/thredd-platform/oci-python:latest
```

## Usage

Copy the Python runtimes into your devcontainer image:

```dockerfile
COPY --from=ghcr.io/thredd-platform/oci-python:latest / /
```

## Version updates

[Renovate](https://docs.renovatebot.com/) is configured to automatically open pull requests when new patch releases of Python are published, keeping `PYTHON_3_12_VERSION`, `PYTHON_3_13_VERSION`, and `PYTHON_3_14_VERSION` in the `Containerfile` up to date.
