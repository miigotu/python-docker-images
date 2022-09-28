ARG PYVER="3.10-slim"

FROM --platform=$TARGETPLATFORM python:${PYVER}

ARG PYVER

RUN echo "Building miigotu/python${PYVER}"

ARG TARGETPLATFORM
ARG BUILDPLATFORM

RUN echo "Host: $BUILDPLATFORM"
RUN echo "Targeting: $TARGETPLATFORM"

ENV PYTHONUNBUFFERED=1
ENV PIP_NO_CACHE_DIR=off
ENV PIP_DISABLE_PIP_VERSION_CHECK=on
ENV PIP_DEFAULT_TIMEOUT=100
ENV VENV_PATH=/opt/venv
ENV PATH="$VENV_PATH/bin:$PATH"

# Install packages
RUN apt-get update && apt-get install -y curl bash && \
 apt-get clean && rm -rf /var/lib/apt/lists/* && rm -rf /usr/share/man/

# Setup venv
RUN python -m venv $VENV_PATH --upgrade
