#!/bin/bash
set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
echo "==> Verificando dependencias..."
if ! docker info > /dev/null 2>&1; then
    echo "[ERROR] Docker no está corriendo. Iniciá Docker Desktop."
    exit 1
fi
echo "==> Construyendo imagen linux-tahoe-builder..."
docker build -t linux-tahoe-builder "$PROJECT_ROOT/docker/"
echo "==> Imagen construida exitosamente."
echo "==> Próximo paso: ./scripts/build.sh"
