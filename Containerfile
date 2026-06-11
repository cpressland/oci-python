FROM docker.io/debian:13 AS build

ARG PYTHON_3_12_VERSION=3.12.13
ARG PYTHON_3_13_VERSION=3.13.13
ARG PYTHON_3_14_VERSION=3.14.4

RUN mkdir -p /python/share /python/local

ENV UV_PYTHON_INSTALL_DIR=/python/share/uv/python \
    UV_TOOL_DIR=/python/share/uv/tools \
    UV_TOOL_BIN_DIR=/python/local/bin \
    UV_PYTHON_BIN_DIR=/python/local/bin

COPY --from=ghcr.io/astral-sh/uv:0.11.6 /uv /python/local/bin/uv

ENV PATH="/python/local/bin:$PATH"

RUN uv python install "${PYTHON_3_12_VERSION}" "${PYTHON_3_13_VERSION}" "${PYTHON_3_14_VERSION}"

RUN ln -sf /python/local/bin/python3.13 /python/local/bin/python3 && \
    ln -sf /python/local/bin/python3.13 /python/local/bin/python

RUN uv tool install --python=3.13 aws-sam-cli && \
    uv tool install --python=3.13 poetry && \
    uv tool install --python=3.13 checkov && \
    uv tool install --python=3.13 pre-commit

FROM scratch
COPY --from=build /python /
