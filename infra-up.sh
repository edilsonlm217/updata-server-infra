#!/bin/bash

set -e  # Faz com que o script pare imediatamente em caso de erro

# Função de rollback para derrubar containers, redes e volumes
rollback() {
  echo "Rollback: Removendo containers, redes e volumes..."
  docker-compose -f nginx/docker-compose.yml down --volumes --remove-orphans || true
  docker-compose -f elasticsearch/docker-compose.yml down --volumes --remove-orphans || true
  docker-compose -f kibana/docker-compose.yml down --volumes --remove-orphans || true
  docker network rm nginx_network || true
  docker network rm internal_network || true
}

# Função para criar rede se não existir
create_network_if_not_exists() {
  local network_name=$1
  if docker network inspect "$network_name" >/dev/null 2>&1; then
    echo "✅ Rede '$network_name' já existe."
  else
    docker network create --driver bridge "$network_name" || { echo "Erro ao criar rede '$network_name'"; rollback; exit 1; }
    echo "🚀 Rede '$network_name' criada com driver bridge."
  fi
}

# Criando redes
echo "🔧 Verificando/criando redes compartilhadas..."
create_network_if_not_exists nginx_network
create_network_if_not_exists internal_network

# Subindo serviços
echo "🚀 Subindo Nginx Proxy Manager..."
docker-compose -f nginx/docker-compose.yml up -d || { echo "Erro ao subir Nginx Proxy Manager"; rollback; exit 1; }

echo "🚀 Subindo Elasticsearch..."
docker-compose -f elasticsearch/docker-compose.yml up -d || { echo "Erro ao subir Elasticsearch"; rollback; exit 1; }

echo "🚀 Subindo Kibana..."
docker-compose -f kibana/docker-compose.yml up -d || { echo "Erro ao subir Kibana"; rollback; exit 1; }

echo "✅ Infraestrutura completa e em execução!"
