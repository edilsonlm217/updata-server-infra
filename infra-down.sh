#!/bin/bash

echo "⬇️ Parando serviços..."
docker compose -f elasticsearch/docker-compose.yml down
docker compose -f kibana/docker-compose.yml down
docker compose -f nginx/docker-compose.yml down

echo "🧹 Removendo redes..."
docker network rm nginx_network internal_network 2>/dev/null

echo "✅ Infra desmontada."
