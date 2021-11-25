FROM naylscloud/python:3.8-slim-poetry-cargo

# Install build-dep packages
RUN apt-get update && \
    \
    apt-get install -y \
        build-essential \
        libssl-dev \
        libffi-dev \
        && \
    \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /usr/share/man/
