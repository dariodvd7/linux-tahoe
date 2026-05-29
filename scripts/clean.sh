#!/bin/bash
set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
[[ "$(uname)" == "Darwin" ]] && SUDO="" || SUDO="sudo"
echo "==> Limpiando volumen Docker..."
$SUDO docker volume rm tahoe-build 2>/dev/null || true
$SUDO docker volume create tahoe-build
echo "==> Limpieza completada."
