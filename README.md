## updata-server-infra

Este repositório contém a infraestrutura Docker necessária para hospedar e orquestrar aplicações distintas em um servidor. Ele utiliza Docker Compose para definir os serviços e redes necessárias, e scripts para facilitar o gerenciamento da infraestrutura.

### Estrutura de diretórios

```plaintext
updata-server-infra/
├── elasticsearch/
│   └── docker-compose.yml
├── kibana/
│   └── docker-compose.yml
├── nginx/
│   └── docker-compose.yml
├── infra-up.sh
├── infra-down.sh
└── README.md
```

### Como funciona?

Este repositório usa o Docker Compose para definir a infraestrutura necessária para suas aplicações. Ele cria redes e serviços como:

* **Nginx Proxy Manager** para gerenciamento de proxies reversos.
* **Elasticsearch** para armazenamento e busca de dados.
* **Kibana** para visualização dos dados do Elasticsearch.

### Pré-requisitos

* **Docker** e **Docker Compose** instalados.
* **Linux/macOS/WSL** recomendados para um ambiente mais simples.

### Como começar?

1. **Clone o repositório:**

```bash
git clone https://seu-repositorio.git
cd updata-server-infra
```

2. **Criação das redes:**

Use o script `infra-up.sh` para criar as redes e iniciar os serviços:

```bash
chmod +x infra-up.sh
./infra-up.sh
```

Este script faz o seguinte:

* Cria as redes `nginx_network` e `internal_network` (caso não existam).
* Inicia os serviços definidos nos arquivos `docker-compose.yml`.

3. **Verifique se os containers estão rodando:**

```bash
docker ps
```

### Como derrubar a infraestrutura?

Use o script `infra-down.sh` para parar os serviços e remover as redes:

```bash
chmod +x infra-down.sh
./infra-down.sh
```

Este script faz o seguinte:

* Para os serviços dos containers.
* Remove as redes `nginx_network` e `internal_network`.

### Explicação dos serviços

* **Nginx Proxy Manager**:

  * Facilita o gerenciamento de proxies reversos e SSL para suas aplicações.
  * Expondo as portas **80** e **443**.

* **Elasticsearch**:

  * Serviço de busca e armazenamento de dados.
  * Configurado para rodar como nó único (`single-node`).

* **Kibana**:

  * Interface de visualização de dados do Elasticsearch.

### Scripts adicionais

* **infra-up.sh**: Cria as redes e sobe os containers.
* **infra-down.sh**: Para os containers e remove as redes criadas.