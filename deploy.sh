#!/usr/bin/env bash
# deploy.sh — reconstruye y verifica el despliegue de la AE4 (curso DPL, UT4)
set -euo pipefail

PUERTO="${PUERTO:-8000}"
BASE="http://localhost:${PUERTO}"

cd "$(dirname "$0")"

echo "[1/3] Construyendo imágenes..."
docker compose build

echo "[2/3] Arrancando servicios..."
docker compose up -d

echo "[3/3] Esperando a que la aplicación esté sana..."
INTENTOS=0
while [ "${INTENTOS}" -lt 30 ]; do
    if curl -sf "${BASE}/healthz" > /dev/null; then
        echo "Despliegue OK: ${BASE}/healthz responde 200"
        exit 0
    fi
    INTENTOS=$((INTENTOS + 1))
    sleep 2
done

echo "ERROR: la aplicación no respondió en 60 s"
docker compose ps
docker compose logs --tail=20
exit 1
