#!/bin/bash

# Uninstall any unofficial docker packages
#for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done

# Install via apt
# Add Docker's official GPG key:
#sudo apt-get update
#sudo apt-get install ca-certificates curl
#sudo install -m 0755 -d /etc/apt/keyrings
#sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
#sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
# echo \
#   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
#   $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
#   sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
# sudo apt-get update

# Install the latest version of docker packages
# sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Turn on bash no case match for regex
docker_version=$(docker --version 2>&1)

# Test if docker is installed correctly
if [[ ! $? -eq 0 ]]; then
    echo "Docker installation failed"
    exit 1
fi

docker_compose_version=$(docker compose version --short 2>&1)

if [[ ! $? -eq 0 ]]; then
    echo "Docker Compose installation failed"
    exit 1
fi

echo "Docker Engine installed successfully"

echo "Loading secrets for Docker Registry"

# Load variables from the secrets file
source .env

# Login to our registry
echo $DOCKER_PASS | docker login --username $DOCKER_USER --password-stdin $DOCKER_REGISTRY