## Example multistage build image

```Dockerfile
FROM --platform=$TARGETPLATFORM miigotu/python:3.9-slim-poetry-cargo-sdk as dependency-image

COPY poetry.lock pyproject.toml ./
RUN poetry install --no-interaction --no-dev --no-root --no-ansi -vvv


FROM --platform=$TARGETPLATFORM miigotu/python:3.9-slim as runtime-image

WORKDIR /app

COPY --from=dependency-image $VENV_PATH $VENV_PATH
COPY ./ ./

ENTRYPOINT faust -A app.worker worker
```
