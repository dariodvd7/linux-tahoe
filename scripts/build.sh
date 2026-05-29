#!/bin/bash
set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
[[ "$(uname)" == "Darwin" ]] && SUDO="" || SUDO="sudo"

echo "==> Copiando config al volumen Docker..."
$SUDO docker run --rm --platform linux/amd64 \
  -v tahoe-build:/build \
  -v "$PROJECT_ROOT/build":/source \
  debian:bookworm bash -c "cp -r /source/. /build/"

echo "==> Iniciando build de Linux Tahoe..."
$SUDO docker compose -f "$PROJECT_ROOT/docker/docker-compose.yml" run --rm linux-tahoe-builder bash -c "
    set -e
    cd /build
    ./auto/config
    lb build 2>&1 | tee build.log
"

echo "==> Copiando ISO al host..."
$SUDO docker run --rm --platform linux/amd64 \
  -v tahoe-build:/build \
  -v "$PROJECT_ROOT/build":/output \
  debian:bookworm bash -c "cp /build/live-image*.iso /output/ 2>/dev/null && cp /build/build.log /output/ 2>/dev/null || true"

echo "==> Build finalizado."
ls -lh "$PROJECT_ROOT/build/"*.iso 2>/dev/null || echo "(No se encontró ISO)"
