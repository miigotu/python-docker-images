ARG PYVER="3.10-slim"

FROM --platform=$TARGETPLATFORM python:${PYVER} as builder
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

ENV CARGO_HOME=/root/.cargo
ENV RUSTUP_HOME=/root/.rustup

ENV PATH="$VENV_PATH/bin:$RUSTUP_HOME/bin:$CARGO_HOME/bin:$PATH"

RUN mkdir $CARGO_HOME $RUSTUP_HOME

# Install packages
RUN apt-get update && apt-get upgrade -yq &&\
 apt-get install -yq curl bash build-essential libffi-dev libssl-dev rustc cargo zlib1g-dev &&\
 apt-get clean && rm -rf /var/lib/apt/lists/* && rm -rf /usr/share/man/

# Setup venv
RUN python -m venv $VENV_PATH --upgrade
RUN python -m pip install --upgrade setuptools pip
RUN python -m pip install --upgrade setuptools-rust wheel


RUN mkdir "/wheels"

RUN pip download --no-binary :all: --no-deps cryptography
RUN tar -xf cryptography*.tar.gz
#RUN cd cryptography*/src/rust && cargo fetch
RUN cd cryptography*/ && python setup.py bdist_wheel --py-limited-api=cp36 && mv dist/cryptography*.whl /wheels
RUN ls /wheels -R


FROM scratch as export-wheels
COPY --from=builder /wheels /

