#!/bin/bash

# Use docker compose to reload the caddy configuration
docker compose exec -w /etc/caddy caddy_reverse_proxy_server caddy reload