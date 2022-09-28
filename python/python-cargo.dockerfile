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
ENV RUSTUP_HOME/root/.rustup

ENV PATH="$CARGO_PATH/bin:$PATH"

RUN apt-get update && \
 curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --default-toolchain none -y && \
 rustup toolchain install nightly --allow-downgrade --profile complete &&\
 pip install --upgrade setuptools-rust &&\
 apt-get clean && rm -rf /var/lib/apt/lists/* && rm -rf /usr/share/man/
