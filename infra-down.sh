#!/bin/bash

set -e

# Detecta se usa "docker compose" (v2) ou "docker-compose" (v1)
if command -v docker compose &> /dev/null; then
  COMPOSE_CMD="docker compose"
else
  COMPOSE_CMD="docker-compose"
fi

echo "⬇️ Parando serviços..."
$COMPOSE_CMD -f elasticsearch/docker-compose.yml down
$COMPOSE_CMD -f kibana/docker-compose.yml down
$COMPOSE_CMD -f nginx/docker-compose.yml down

echo "🧹 Removendo redes..."
docker network rm nginx_network internal_network 2>/dev/null || true

echo "✅ Infra desmontada."
