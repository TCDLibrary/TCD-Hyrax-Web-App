#!/bin/bash

# Remove old versions of docker
sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine

# Install required packages
sudo yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2

# Add the stable repository
sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

# Install docker
sudo yum -y install docker-ce docker-ce-cli containerd.io
sudo systemctl start docker
sudo systemctl enable docker

# Install docker compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Allow docker without sudo
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker 