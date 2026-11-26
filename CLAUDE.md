# CLAUDE.md — Linux Tahoe

Distribución live basada en Debian Bookworm + KDE Plasma 6 con look de macOS Tahoe.
Target: **Mac Mini 2012 (x86_64, EFI de Apple)**. Se construye con `live-build`
dentro de Docker.

## Reglas importantes

- El build corre en un contenedor **privileged** con `--platform linux/amd64`. En Linux los
  scripts usan `sudo`, en macOS no. Mantener esa compatibilidad.
- Un build completo tarda y baja muchos paquetes: no lanzarlo sin pedirlo. Para validar un
  cambio, alcanza con `sh -n` en scripts/hooks y revisar las listas de paquetes.
- Los artefactos (`*.iso`, `build.log`, chroot) no se commitean.
- Cuidado con los hooks de arranque Apple EFI y la fuente de GRUB
  (`0001-grub-font.hook.binary`, `0002-apple-efi.hook.binary`): son el fix que hace bootear
  el Mac Mini 2012.

## Estructura

- `build/auto/config`: opciones de `lb config` (bookworm, main/contrib/non-free(-firmware),
  iso-hybrid, grub-efi, sin debian-installer).
- `build/config/package-lists/*.list.chroot`: paquetes (`base`, `kde`, `live`,
  `hardware-macmini`, `tahoe-theme`).
- `build/config/hooks/normal/`: hooks `.chroot` y `.binary`. Los de numeración baja son propios.
  La mayoría de los 1000–9xxx son los default de live-build.
- `build/config/bootloaders/grub-pc/config.cfg`: menú de GRUB.
- `installer/calamares/branding/tahoeos/`: branding de Calamares.
- `docker/`: imagen del builder (`linux-tahoe-builder`) y compose con el volumen `tahoe-build`.
- El README menciona `assets/` y `docs/`, que todavía no existen en el repo.

## Comandos

```bash
./scripts/setup-build-env.sh   # construye la imagen Docker del builder
./scripts/build.sh             # copia build/ al volumen, corre lb build, saca la ISO a build/
./scripts/clean.sh             # recrea el volumen tahoe-build
```

La ISO queda en `build/live-image-amd64.hybrid.iso` y el log en `build/build.log`.

## Agregar paquetes o temas

- Paquetes: agregar a la `.list.chroot` que corresponda (uno por línea). Verificar que
  existan en bookworm (`apt-cache policy` dentro del builder).
- Configuración del sistema: `build/config/includes.chroot/` (crear si hace falta) o un hook
  `.hook.chroot` nuevo con número propio (`00xx`).
