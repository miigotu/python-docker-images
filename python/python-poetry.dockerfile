ARG PYVER="3.10-slim"

FROM --platform=$TARGETPLATFORM miigotu/python:${PYVER}

ARG PYVER

RUN echo "Building miigotu/python${PYVER}-poetry"

ARG TARGETPLATFORM
ARG BUILDPLATFORM

RUN echo "Host: $BUILDPLATFORM"
RUN echo "Targeting: $TARGETPLATFORM"

ENV POETRY_PATH=/root/.local
ENV POETRY_VERSION=1.2.0
ENV PATH="$POETRY_PATH/bin:$PATH"

# Install poetry
RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/install-poetry.py | python - && \
 poetry --version && poetry config virtualenvs.create false