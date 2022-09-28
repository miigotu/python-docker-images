ARG PYVER="3.10-slim"

FROM --platform=$TARGETPLATFORM miigotu/python:${PYVER}-cargo

ARG PYVER

RUN echo "Building miigotu/python${PYVER}-cargo-sdk"

ARG TARGETPLATFORM
ARG BUILDPLATFORM

RUN echo "Host: $BUILDPLATFORM"
RUN echo "Targeting: $TARGETPLATFORM"

# Install build-dep packages
RUN apt-get update && apt-get install -y build-essential libssl-dev libffi-dev && \
 apt-get clean && rm -rf /var/lib/apt/lists/* && rm -rf /usr/share/man/
