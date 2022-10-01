FROM --platform=$TARGETPLATFORM rust:bullseye as prebuilder
ARG PYVER

RUN echo "Building python${PYVER}-cryptography"

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

RUN apt-get update -yq && apt-get install -y software-properties-common build-essential extra-runtime-dependencies && \
    curl bash libffi-dev libssl-dev zlib1g-dev && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && apt-get install -y python$PYVER python$PYVER-venv python$PYVER-pip python$PYVER-apt && \
    update-alternatives --install /usr/bin/python3 python3 /usr/bin/python$PYVER 1 \

# Setup venv
RUN python3 -m venv $VENV_PATH --upgrade
RUN python3 -m pip install --upgrade setuptools pip
RUN python3 -m pip install --upgrade setuptools-rust wheel

FROM --platform=$TARGETPLATFORM miigotu/rust-python-builder as builder

ENV PYTHONUNBUFFERED=1
ENV PIP_NO_CACHE_DIR=off
ENV PIP_DISABLE_PIP_VERSION_CHECK=on
ENV PIP_DEFAULT_TIMEOUT=100

ENV VENV_PATH=/opt/venv
ENV PATH="$VENV_PATH/bin:$PATH"

RUN pip wheel cryptography --wheel-dir /wheels


FROM scratch as export-wheels
COPY --from=builder /wheels /