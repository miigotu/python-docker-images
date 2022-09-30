ARG PYVER="3.11"
ARG ARCH="aarch64"
FROM quay.io/pypa/manylinux2014_$ARCH AS manylinux

FROM rustembedded/cross:$ARCH-unknown-linux-gnu

RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y python$PYVER && \
    update-alternatives --install /usr/bin/python3 python3 /usr/bin/python$PYVER 1

COPY --from=manylinux /opt/_internal /opt/_internal
COPY --from=manylinux /opt/python /opt/python