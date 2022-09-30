ARG PYVER="3.10-slim"

FROM --platform=$BUILDPLATFORM python:${PYVER} as prebuilder
# A docker stage that caches the cargo index for the cryptography deps. This is
# mainly useful for multi-arch builds where fetching the index from the internet
# fails for 32bit archs built on 64 bit platforms.

ARG PYVER

RUN echo "Building python${PYVER}-cryptography"

ARG TARGETPLATFORM
ARG BUILDPLATFORM

RUN echo "Host: $BUILDPLATFORM"
RUN echo "Targeting: $TARGETPLATFORM"

RUN apt-get update && apt-get install -y build-essential libffi-dev libssl-dev rust-all cargo zlib1g-dev && rm -rf /var/lib/apt/lists/*

ENV CARGO_HOME=/root/.cargo
ENV RUSTUP_HOME=/root/.rustup
RUN mkdir $CARGO_HOME $RUSTUP_HOME

RUN pip download --no-binary :all: --no-deps cryptography

RUN tar -xf cryptography*.tar.gz --wildcards cryptography*/src/rust/

RUN cd cryptography*/src/rust && cargo fetch


FROM --platform=$TARGETPLATFORM python:${PYVER} as builder

ENV CARGO_NET_OFFLINE=true
ENV CARGO_HOME=/root/.cargo
ENV RUSTUP_HOME=/root/.rustup


RUN apt-get update && apt-get install -y build-essential libffi-dev libssl-dev rust-all cargo zlib1g-dev && rm -rf /var/lib/apt/lists/*

COPY --from=prebuilder $CARGO_HOME $CARGO_HOME
COPY --from=prebuilder $RUSTUP_HOME $RUSTUP_HOME

RUN mkdir "/wheels"
RUN #pip install cryptography
RUN pip wheel cryptography --wheel-dir /wheels

FROM scratch as export-wheels
COPY --from=builder /wheels /

RUN ls / -R