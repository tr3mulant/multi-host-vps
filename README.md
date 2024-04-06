# VPS with Caddy Reverse Proxy for Multiple Hosted Applications

Runs all docker images for side projects. To setup a new VPS:

1. `ssh user@vps_ip_address`
2. `cd /path/to/project`
3. `git clone https://github.com/tr3mulant/vps-proxy-multi-site`
4. `cd vps-proxy-multi-site`
5. `./install.sh`
   1. Installs required packages for a `Ubuntu 22.x` VPS instance from a provider like [DigitalOcean](https://digitalocean.com):
      - `ca-certificates`
      - `curl`
      - `docker-ce`
      - `docker-ce-cli`
      - `containerd.io`
      - `docker-buildx-plugin`
      - `docker-compose-plugin`
   2. Pulls the images as defined in `docker-compose.yml`.
      - This requires a `.env` file with some variables set in order to login to a docker registry of choice with associated credentials.
        - `DOCKER_USER`
        - `DOCKER_PASS`
        - `DOCKER_REGISTRY`
      - **Note:** the script assumes all images needed in `docker-compose.yml` are located in the registry pointed to by the `DOCKER_REGISTRY` env variable.
   3. Once the images are pulled, docker compose builds the containers and starts them

To add a new side project:

1. Build project as a standalone image in the same registry pointed to by `DOCKER_REGISTRY` in the `.env` file
2. Add new docker compose definition to `docker-compose.yml`
3. Commit and push to github repository
4. `ssh user@vps_ip_address`
5. `./update.sh`
   1. Install repository if it does not exist
   2. Pull latest changes from `main` branch
6. `./reload.sh`
   1. Reloads the Caddy reverse proxy
