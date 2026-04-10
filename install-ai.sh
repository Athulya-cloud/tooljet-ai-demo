#!/bin/bash
set -e

GREEN='\033[0;32m'; RED='\033[0;31m'; NC='\033[0m'
ok()   { echo -e "${GREEN}✔ $1${NC}"; }
fail() { echo -e "${RED}✘ $1${NC}"; exit 1; }

echo "========================================"
echo "   ToolJet AI Server — Installer"
echo "========================================"

command -v docker >/dev/null 2>&1 || fail "Docker not found."
ok "Docker found"

if [ -z "$GHCR_TOKEN" ]; then
  fail "GHCR_TOKEN not set."
fi
ok "GHCR token found"

echo "$GHCR_TOKEN" | docker login ghcr.io -u tooljet-client --password-stdin && ok "Logged into GHCR" || fail "GHCR login failed."

curl -sSL "https://tooljet.com/docker-compose.ai.yml" -o docker-compose.ai.yml && ok "Downloaded compose file"

docker compose -f docker-compose.yml -f docker-compose.ai.yml up -d && ok "All services started!"

echo "========================================"
echo "  AI Server  → http://localhost:8000"
echo "  Neo4j UI   → http://localhost:7474"
echo "========================================"
