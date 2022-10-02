FROM --platform=$TARGETPLATFORM rust:bullseye as prebuilder
ARG PYVER
ENV PYVER=$PYVER

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

# Install compiler and dependencies
RUN apt-get update -yq && apt-get install -yq build-essential libffi-dev libssl-dev libncurses5-dev \
    zlib1g-dev libgdbm-dev libnss3-dev libreadline-dev libsqlite3-dev wget libbz2-dev && \
    apt-get upgrade -yq && apt-get clean -yq && rm -rf /var/lib/apt/lists/* && rm -rf /usr/share/man/

# Build python
RUN V=$(curl https://www.python.org/ftp/python/ -s | grep "href=\"${PYVER}" | sed -s 's/.*">//g; s/\/<.*//g' | sort -r) && \
    PYTHON_VERSION=$(echo $V | awk '{ print $1 }') && echo "Latest version of ${PYVER} is ${PYTHON_VERSION}" && \
    wget https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz && \
    tar -xvf Python-${PYTHON_VERSION}.tgz && cd Python-${PYTHON_VERSION} &&  \
    ./configure --enable-optimizations && make -j $(nproc) && make install && cd .. && \
    rm -rf Python-${PYTHON_VERSION}.tgz Python-${PYTHON_VERSION} && which python$PYVER && python$PYVER --version

# Setup venv
RUN which python$PYVER && python$PYVER --version && which python3 && python3 --version
RUN python3 -m venv $VENV_PATH --upgrade
RUN python3 -m pip install --upgrade setuptools pip
RUN python3 -m pip install --upgrade setuptools-rust wheel

FROM --platform=$TARGETPLATFORM prebuilder as builder

ENV PYTHONUNBUFFERED=1
ENV PIP_NO_CACHE_DIR=off
ENV PIP_DISABLE_PIP_VERSION_CHECK=on
ENV PIP_DEFAULT_TIMEOUT=100

ENV VENV_PATH=/opt/venv
ENV PATH="$VENV_PATH/bin:$PATH"

ARG PACKAGES="pycparser cffi greenlet lxml MarkupSafe msgpack SQLAlchemy tornado wrapt cryptography PyNaCl"
RUN RUN --mount=type=tmpfs,target=/root/.cargo pip install pycparser && pip wheel $PACKAGES --require-virtualenv --wheel-dir /wheels


FROM scratch as export-wheels
COPY --from=builder /wheels /