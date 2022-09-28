ARG PYVER="3.10-slim"

FROM --platform=$TARGETPLATFORM miigotu/python:${PYVER}-cargo-sdk

ARG PYVER

RUN echo "Building miigotu/python${PYVER}-cargo-sdk-cryptography"

ARG TARGETPLATFORM
ARG BUILDPLATFORM

RUN echo "Host: $BUILDPLATFORM"
RUN echo "Targeting: $TARGETPLATFORM"

# Install build-dep packages
# Cheat for now, using depends from https://www.piwheels.org/logs/0000/0739/4023.txt
RUN pip install --ignore-installed --no-user --prefix /tmp/pip-build-env-17bakmnp/overlay --no-warn-script-location -v --no-binary cryptography --only-binary :none: -i https://pypi.org/simple --extra-index-url https://www.piwheels.org/simple --prefer-binary -- 'setuptools>=40.6.0' wheel 'cffi>=1.12; platform_python_implementation != '"'"'PyPy'"'"'' 'setuptools-rust>=0.11.4'
