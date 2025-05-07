#!/bin/bash

set -e

# Força o uso do docker-compose (v1)
COMPOSE_CMD="docker-compose"

echo "⬇️ Parando serviços..."
$COMPOSE_CMD -f elasticsearch/docker-compose.yml down
$COMPOSE_CMD -f kibana/docker-compose.yml down
$COMPOSE_CMD -f nginx/docker-compose.yml down
$COMPOSE_CMD -f portainer/docker-compose.yml down

echo "🧹 Removendo redes..."
docker network rm nginx_network internal_network 2>/dev/null | true

echo "✅ Infra desmontada."
