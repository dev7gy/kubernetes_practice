#!/opt/homebrew/bin/bash
k3d cluster create my-lab \
  --servers 1 \
  --agents 2 \
  --port "8080:80@loadbalancer" \
  --k3s-arg "--disable=traefik@server:0"
