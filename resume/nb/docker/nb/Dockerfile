#FROM continuumio/miniconda
FROM jupyter/scipy-notebook
#FROM jupyter/datascience-notebook

#RUN dnf update && dnf install -y libicu-devel && dnf clean

RUN apt-get update && apt-get install -y \
    libicu-dev \
    && rm -rf /var/lib/apt/lists/*

RUN conda install -y -c conda-forge spacy; pip install polyglot