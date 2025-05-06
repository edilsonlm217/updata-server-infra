#!/bin/bash

set -e

echo "🔧 Verificando/criando redes compartilhadas..."

create_network_if_not_exists() {
  local network_name=$1
  if docker network inspect "$network_name" >/dev/null 2>&1; then
    echo "✅ Rede '$network_name' já existe."
  else
    docker network create --driver bridge "$network_name"
    echo "🚀 Rede '$network_name' criada com driver bridge."
  fi
}

create_network_if_not_exists nginx_network
create_network_if_not_exists internal_network

echo "🚀 Subindo Nginx Proxy Manager..."
docker-compose -f nginx/docker-compose.yml up -d

echo "🚀 Subindo Elasticsearch..."
docker-compose -f elasticsearch/docker-compose.yml up -d

echo "🚀 Subindo Kibana..."
docker-compose -f kibana/docker-compose.yml up -d

echo "✅ Infraestrutura completa e em execução!"
