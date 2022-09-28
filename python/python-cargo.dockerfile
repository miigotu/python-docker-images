ARG PYVER="3.10-slim"

FROM --platform=$TARGETPLATFORM miigotu/python:${PYVER}

ARG PYVER

RUN echo "Building miigotu/python${PYVER}-cargo"

ARG TARGETPLATFORM
ARG BUILDPLATFORM

RUN echo "Host: $BUILDPLATFORM"
RUN echo "Targeting: $TARGETPLATFORM"

# Install cargo and rust toolchain
ENV CARGO_PATH=/root/.cargo
ENV RUSTUP_HOME=/root/.rustup

ENV PATH="$CARGO_PATH/bin:$PATH"

RUN apt-get update && apt install python3-apt -yq

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y && \
 pip install --upgrade setuptools-rust
