#!/usr/bin/env bash

# ========================================
# ============ RUNTIME IMAGES ============
# ========================================

# -------------- PYTHON 3.8 --------------

printf "\n=== miigotu/python:3.8-slim ==="
printf "\n-----------------------------\n"
docker build \
    -t miigotu/python:3.8-slim \
    -f ./3.8/python3.8-slim.dockerfile \
    ./3.8 || exit 1
docker push miigotu/python:3.8-slim || exit 1

printf "\n=== miigotu/python:3.8-slim-poetry ==="
printf "\n------------------------------------\n"
docker build \
    -t miigotu/python:3.8-slim-poetry \
    -f ./3.8/python3.8-slim-poetry.dockerfile \
    ./3.8 || exit 1
docker push miigotu/python:3.8-slim-poetry || exit 1

printf "\n=== miigotu/python:3.8-slim-poetry-cargo ==="
printf "\n------------------------------------------\n"
docker build \
    -t miigotu/python:3.8-slim-poetry-cargo \
    -f ./3.8/python3.8-slim-poetry-cargo.dockerfile \
    ./3.8 || exit 1
docker push miigotu/python:3.8-slim-poetry-cargo || exit 1

# -------------- PYTHON 3.9 --------------

printf "\n=== miigotu/python:3.9-slim ==="
printf "\n-----------------------------\n"
docker build \
    -t miigotu/python:3.9-slim \
    -f ./3.9/python3.9-slim.dockerfile \
    ./3.9 || exit 1
docker push miigotu/python:3.9-slim || exit 1

printf "\n=== miigotu/python:3.9-slim-poetry ==="
printf "\n------------------------------------\n"
docker build \
    -t miigotu/python:3.9-slim-poetry \
    -f ./3.9/python3.9-slim-poetry.dockerfile \
    ./3.9 || exit 1
docker push miigotu/python:3.9-slim-poetry || exit 1

printf "\n=== miigotu/python:3.9-slim-poetry-cargo ==="
printf "\n------------------------------------------\n"
docker build \
    -t miigotu/python:3.9-slim-poetry-cargo \
    -f ./3.9/python3.9-slim-poetry-cargo.dockerfile \
    ./3.9 || exit 1
docker push miigotu/python:3.9-slim-poetry-cargo || exit 1

# -------------- PYTHON 3.10 --------------

printf "\n=== miigotu/python:3.10-slim ==="
printf "\n-----------------------------\n"
docker build \
    -t miigotu/python:3.10-slim \
    -f ./3.10/python3.10-slim.dockerfile \
    ./3.10 || exit 1
docker push miigotu/python:3.10-slim || exit 1

printf "\n=== miigotu/python:3.10-slim-poetry ==="
printf "\n------------------------------------\n"
docker build \
    -t miigotu/python:3.10-slim-poetry \
    -f ./3.10/python3.10-slim-poetry.dockerfile \
    ./3.10 || exit 1
docker push miigotu/python:3.10-slim-poetry || exit 1

printf "\n=== miigotu/python:3.10-slim-poetry-cargo ==="
printf "\n------------------------------------------\n"
docker build \
    -t miigotu/python:3.10-slim-poetry-cargo \
    -f ./3.10/python3.10-slim-poetry-cargo.dockerfile \
    ./3.10 || exit 1
docker push miigotu/python:3.10-slim-poetry-cargo || exit 1


# ========================================
# ============== SDK IMAGES ==============
# ========================================

# -------------- PYTHON 3.8 --------------

printf "\n=== miigotu/python:3.8-slim-sdk ==="
printf "\n-----------------------------\n"
docker build \
    -t miigotu/python:3.8-slim-sdk \
    -f ./3.8/python3.8-slim-sdk.dockerfile \
    ./3.8 || exit 1
docker push miigotu/python:3.8-slim-sdk || exit 1

printf "\n=== miigotu/python:3.8-slim-poetry-sdk ==="
printf "\n------------------------------------\n"
docker build \
    -t miigotu/python:3.8-slim-poetry-sdk \
    -f ./3.8/python3.8-slim-poetry-sdk.dockerfile \
    ./3.8 || exit 1
docker push miigotu/python:3.8-slim-poetry-sdk || exit 1

printf "\n=== miigotu/python:3.8-slim-poetry-cargo-sdk ==="
printf "\n------------------------------------------\n"
docker build \
    -t miigotu/python:3.8-slim-poetry-cargo-sdk \
    -f ./3.8/python3.8-slim-poetry-cargo-sdk.dockerfile \
    ./3.8 || exit 1
docker push miigotu/python:3.8-slim-poetry-cargo-sdk || exit 1

# -------------- PYTHON 3.9 --------------

printf "\n=== miigotu/python:3.9-slim-sdk ==="
printf "\n-----------------------------\n"
docker build \
    -t miigotu/python:3.9-slim-sdk \
    -f ./3.9/python3.9-slim-sdk.dockerfile \
    ./3.9 || exit 1
docker push miigotu/python:3.9-slim-sdk || exit 1

printf "\n=== miigotu/python:3.9-slim-poetry-sdk ==="
printf "\n------------------------------------\n"
docker build \
    -t miigotu/python:3.9-slim-poetry-sdk \
    -f ./3.9/python3.9-slim-poetry-sdk.dockerfile \
    ./3.9 || exit 1
docker push miigotu/python:3.9-slim-poetry-sdk || exit 1

printf "\n=== miigotu/python:3.9-slim-poetry-cargo-sdk ==="
printf "\n------------------------------------------\n"
docker build \
    -t miigotu/python:3.9-slim-poetry-cargo-sdk \
    -f ./3.9/python3.9-slim-poetry-cargo-sdk.dockerfile \
    ./3.9 || exit 1
docker push miigotu/python:3.9-slim-poetry-cargo-sdk || exit 1

# -------------- PYTHON 3.10 --------------

printf "\n=== miigotu/python:3.10-slim-sdk ==="
printf "\n-----------------------------\n"
docker build \
    -t miigotu/python:3.10-slim-sdk \
    -f ./3.10/python3.10-slim-sdk.dockerfile \
    ./3.10 || exit 1
docker push miigotu/python:3.10-slim-sdk || exit 1

printf "\n=== miigotu/python:3.10-slim-poetry-sdk ==="
printf "\n------------------------------------\n"
docker build \
    -t miigotu/python:3.10-slim-poetry-sdk \
    -f ./3.10/python3.10-slim-poetry-sdk.dockerfile \
    ./3.10 || exit 1
docker push miigotu/python:3.10-slim-poetry-sdk || exit 1

printf "\n=== miigotu/python:3.10-slim-poetry-cargo-sdk ==="
printf "\n------------------------------------------\n"
docker build \
    -t miigotu/python:3.10-slim-poetry-cargo-sdk \
    -f ./3.10/python3.10-slim-poetry-cargo-sdk.dockerfile \
    ./3.10 || exit 1
docker push miigotu/python:3.10-slim-poetry-cargo-sdk || exit 1