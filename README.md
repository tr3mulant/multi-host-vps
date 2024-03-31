# Multi Site VPS with Caddy Reverse Proxy

Runs all docker iamges for side projects. To setup a new VPS:

1. `ssh root@VPS_IP_ADDRESS`
2. `cd /root`
3. `git clone https://github.com/tr3mulant/multi-host-vps`
4. `cd multi-host-vps`
5. `./install.sh`
   1. Installs required packages for a `Ubuntu 22.x` VPS instance from a provider like DigitalOcean.
   2. This requires a `.env` file with some variables set in order to login to a docker registry of choice with associated credentials. **Note:** the script assumes all images needed in `docker-compose.yml` are located in the registry pointed to by the `DOCKER_REGISTRY` env variable.
      - `DOCKER_USER`
      - `DOCKER_PASS`
      - `DOCKER_REGISTRY`
6. `docker compose up -d`
