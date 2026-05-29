#!/bin/bash
set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
[[ "$(uname)" == "Darwin" ]] && SUDO="" || SUDO="sudo"
echo "==> Verificando Docker..."
if ! $SUDO docker info > /dev/null 2>&1; then
    echo "[ERROR] Docker no responde."
    exit 1
fi
echo "==> Construyendo imagen..."
$SUDO docker build --platform linux/amd64 -t linux-tahoe-builder:latest "$PROJECT_ROOT/docker/"
echo "==> Listo. Corré ./scripts/build.sh"
