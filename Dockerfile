
FROM docker.io/sphinxdoc/sphinx:latest

LABEL "maintainer"="Wes Turner <@westurner>"

ARG NB_USER=jovyan
ARG NB_UID=1000

RUN useradd --uid "${NB_UID}" --create-home --shell /bin/bash "${NB_USER}"
RUN apt-get update && apt-get install -y git && apt-get clean && rm -rf /var/lib/apt/cache

RUN mkdir -m 773 -p /workdir && chown "${NB_USER}" /workdir
USER ${NB_USER}
COPY --chown=${NB_USER}:${NB_USER} Makefile /workdir/Makefile
COPY --chown=${NB_USER}:${NB_USER} requirements.txt /workdir/requirements.txt

RUN cat /workdir/Makefile && \
    make -C /workdir install
RUN PATH="/home/${NB_USER}/.local/bin:${PATH}" \
    make -C /workdir build
