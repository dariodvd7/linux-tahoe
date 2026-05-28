# Linux Tahoe

Distribución Linux basada en Debian Bookworm con KDE Plasma 6, con look idéntico a macOS Tahoe.

**Target:** Mac Mini 2012 (x86_64)

## Requisitos

- Docker Desktop (macOS) o Docker Engine (Linux)
- 15 GB de espacio libre en disco
- Conexión a internet para descargar paquetes

## Build

```bash
# 1. Configurar entorno (construye la imagen Docker)
./scripts/setup-build-env.sh

# 2. Generar ISO
./scripts/build.sh

# 3. Limpiar artefactos de build
./scripts/clean.sh
```

## Estructura

```
linux-tahoe/
├── build/          # Configuración de live-build (lb)
│   ├── auto/       # Scripts auto/config, auto/build, auto/clean
│   └── config/     # Package lists, hooks, includes
├── assets/         # Wallpapers, fuentes, iconos, temas, SDDM, Plymouth
├── installer/      # Calamares (branding y módulos)
├── docker/         # Dockerfile y docker-compose.yml del builder
├── scripts/        # build.sh, clean.sh, setup-build-env.sh
└── docs/           # Documentación adicional
```

## Componentes principales

| Componente     | Valor                        |
|----------------|------------------------------|
| Base           | Debian Bookworm (12)         |
| Escritorio     | KDE Plasma 6                 |
| Display manager| SDDM                         |
| Audio          | PipeWire + WirePlumber       |
| Red            | NetworkManager               |
| Instalador     | Calamares                    |
| Arquitectura   | x86_64                       |
