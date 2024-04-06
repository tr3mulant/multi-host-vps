# VPS with Caddy Reverse Proxy for Multiple Hosted Applications

Runs all docker iamges for side projects. To setup a new VPS:

1. `ssh user@VPS_IP_ADDRESS`
2. `cd /path/to/project`
3. `git clone https://github.com/tr3mulant/vps-proxy-multi-site`
4. `cd vps-proxy-multi-site`
5. `./install.sh`
   1. Installs required packages for a `Ubuntu 22.x` VPS instance from a provider like DigitalOcean.
   2. This requires a `.env` file with some variables set in order to login to a docker registry of choice with associated credentials. **Note:** the script assumes all images needed in `docker-compose.yml` are located in the registry pointed to by the `DOCKER_REGISTRY` env variable.
      - `DOCKER_USER`
      - `DOCKER_PASS`
      - `DOCKER_REGISTRY`
6. `docker compose up -d`

To add a new side project:

1. Build project as a standalone image in the same registry pointed to by `DOCKER_REGISTRY` in the `.env` file
2. Add new docker compose definition to `docker-compose.yml`
3. Commit and push to git
4. `ssh user@VPS_IP_ADDRESS`
5. `./update.sh`
6. `./reload.sh`
