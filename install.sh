#!/bin/bash

# Uninstall any unofficial docker packages
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do 
  sudo apt-get remove "$pkg"
done

# Add Docker's official GPG key:
sudo apt-get update && sudo apt-get install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc 
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources and update 
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# Install the latest version of docker packages
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Test if docker is installed correctly
if ! docker --version &> /dev/null; then
  echo "Docker installation failed"
  exit 1
fi

# Test if docker compose is installed correctly
if ! docker compose version --short &> /dev/null; then
  echo "Docker Compose installation failed"
  exit 1
fi

echo -e "Docker Engine installed successfully\nLoading secrets for Docker Registry"

# Check for the required .env file
if [ ! -f .env ]; then
  echo "Error: .env file not found"
  exit 1
fi

# Source the .env to Load variables and login to docker registry
. .env && echo "$DOCKER_PASS" | docker login --username "$DOCKER_USER" --password-stdin "$DOCKER_REGISTRY"

# Fetch the images from the registry and start the show
docker compose up -d --pull "always" --dry-run