#!/bin/bash
set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
if [[ "$(uname)" == "Darwin" ]]; then
    SUDO=""
else
    SUDO="sudo"
fi
echo "==> Iniciando build de Linux Tahoe..."
docker compose -f "$PROJECT_ROOT/docker/docker-compose.yml" run --rm linux-tahoe-builder bash -c "
    set -e
    cd /build
    ./auto/config
    lb build 2>&1 | tee build.log
"
echo "==> Build finalizado."
echo "==> ISO generada en build/:"
ls -lh "$PROJECT_ROOT/build/"/live-image*.iso 2>/dev/null || echo "(No se encontró ISO — revisá build.log)"
