
FROM docker.io/sphinxdoc/sphinx:latest

LABEL "maintainer"="Wes Turner <@westurner>"

ARG NB_USER=jovyan
ARG NB_UID=1000

RUN useradd --uid "${NB_UID}" --create-home --shell /bin/bash "${NB_USER}"
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt-get update && apt-get install -y --no-install-recommends \
    bash-completion \
    curl \
    ca-certificates \
    bzip2 \
    git \
    make \
    && rm -rf /var/lib/apt/lists/*

# TODO: add ripgrep \

# Create /workdir
RUN mkdir -m 773 -p /workdir && chown "${NB_USER}" /workdir
USER ${NB_USER}


# Download and install Miniforge (which includes mamba)
ENV CONDA_DIR=/workdir/miniforge
ENV MINIFORGE_URL_PREFIX="https://github.com/conda-forge/miniforge/releases/latest/download/"
ENV MINIFORGE_URL=
RUN --mount=type=cache,target=/tmp/downloads,uid=${NB_UID} \
    set -x; \
    export MINIFORGE_INSTALLER="Miniforge3-$(uname)-$(uname -m).sh"; \
    export MINIFORGE_URL="${MINIFORGE_URL:-"${MINIFORGE_URL_PREFIX}/${MINIFORGE_INSTALLER}"}"; \
    if [ ! -f "/tmp/downloads/${MINIFORGE_INSTALLER}" ]; then \
        curl -L -o "/tmp/downloads/${MINIFORGE_INSTALLER}" "${MINIFORGE_URL}"; \
    fi && \
    bash "/tmp/downloads/${MINIFORGE_INSTALLER}" -b -p "${CONDA_DIR}"

# Put mamba/conda on PATH
ENV PATH=${CONDA_DIR}/bin:/home/${NB_USER}/.local/bin:${PATH}
ENV CONDA_PKGS_DIRS=/home/${NB_USER}/.cache/conda/pkgs


COPY --chown=${NB_USER}:${NB_USER} Makefile /workdir/Makefile
COPY --chown=${NB_USER}:${NB_USER} requirements.txt /workdir/requirements.txt

RUN --mount=type=cache,target=/home/jovyan/.pip/cache,uid=${NB_UID} \
    --mount=type=cache,target=/home/${NB_USER}/.cache/conda/pkgs,uid=${NB_UID} \
    cat /workdir/Makefile && \
    make -C /workdir install
    # 	pip install --exists-action=s -r requirements.txt


# Verify installation
#RUN --mount=type=cache,target=/home/${NB_USER}/.cache/conda/pkgs,uid=${NB_UID} \
RUN mamba --version && mamba info


# COPY --chown=${NB_USER}:${NB_USER} conf.py /workdir/conf.py
# RUN PATH="/home/${NB_USER}/.local/bin:${PATH}" \
#     make -C /workdir build
