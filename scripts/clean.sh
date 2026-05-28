#!/bin/bash
set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
echo "==> Limpiando build de Linux Tahoe..."
docker compose -f "$PROJECT_ROOT/docker/docker-compose.yml" run --rm linux-tahoe-builder bash -c "
    set -e
    cd /build
    lb clean
"
echo "==> Limpieza completada."
