#!/bin/bash

# Atualizando pacotes e instalando dependências
echo "Atualizando pacotes e instalando dependências..."
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install -y wget curl tar

# Configurando o firewall para permitir acesso HTTP e HTTPS
echo "Configurando firewall..."
sudo ufw allow 22/tcp
sudo ufw allow 9090/tcp    # Porta do Prometheus
sudo ufw allow 3000/tcp    # Porta do Grafana
sudo ufw --force enable

# Instalando o Prometheus
echo "Instalando Prometheus..."
PROMETHEUS_VERSION="2.54.1"
cd /tmp/
wget https://github.com/prometheus/prometheus/releases/download/v${PROMETHEUS_VERSION}/prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz
tar -xvf prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz
sudo mv prometheus-${PROMETHEUS_VERSION}.linux-amd64 /usr/local/bin/prometheus

# Criando usuário e diretório de configuração para o Prometheus
sudo useradd --no-create-home --shell /bin/false prometheus
sudo mkdir /etc/prometheus
sudo mkdir /var/lib/prometheus
sudo chown prometheus:prometheus /usr/local/bin/prometheus/*
sudo chown -R prometheus:prometheus /etc/prometheus /var/lib/prometheus

# Configurando o Prometheus
echo "Configurando Prometheus..."
cat <<EOF | sudo tee /etc/prometheus/prometheus.yml
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: "prometheus"
    static_configs:
      - targets: ["localhost:9090"]
EOF

# Criando serviço systemd para o Prometheus
cat <<EOF | sudo tee /etc/systemd/system/prometheus.service
[Unit]
Description=Prometheus Service
After=network.target

[Service]
User=prometheus
ExecStart=/usr/local/bin/prometheus/prometheus --config.file=/etc/prometheus/prometheus.yml --storage.tsdb.path=/var/lib/prometheus/

[Install]
WantedBy=multi-user.target
EOF

# Iniciando e habilitando o serviço Prometheus
sudo systemctl daemon-reload
sudo systemctl start prometheus
sudo systemctl enable prometheus

# Instalando o Grafana
echo "Instalando Grafana..."
sudo apt-get install -y apt-transport-https software-properties-common
wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
sudo add-apt-repository "deb https://packages.grafana.com/oss/deb stable main"
sudo apt-get update -y
sudo apt-get install -y grafana

# Iniciando e habilitando o serviço Grafana
sudo systemctl start grafana-server
sudo systemctl enable grafana-server

# Finalizando
echo "Instalação e configuração do Prometheus e Grafana concluída."
echo "Acesse o Grafana via http://<SEU_IP>:3000 (login: admin, senha: admin)"
echo "Acesse o Prometheus via http://<SEU_IP>:9090"

#Para usar:
#Salve o script como setup_prometheus_grafana.sh.
#Dê permissão de execução:
#chmod +x setup_prometheus_grafana.sh
#sudo ./setup_prometheus_grafana.sh
#Isso configurará o ambiente com o Prometheus e Grafana prontos para uso!