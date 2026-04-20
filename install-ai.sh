#!/bin/bash
set -e

GREEN='\033[0;32m'; RED='\033[0;31m'; YELLOW='\033[1;33m'; NC='\033[0m'
ok()   { echo -e "${GREEN}✔ $1${NC}"; }
fail() { echo -e "${RED}✘ $1${NC}"; exit 1; }
info() { echo -e "${YELLOW}→ $1${NC}"; }

echo ""
echo "========================================"
echo "   ToolJet AI — Installer"
echo "========================================"
echo ""

# step 1: check docker
info "Checking dependencies..."
command -v docker >/dev/null 2>&1 || fail "Docker not found. Install Docker first."
ok "Docker found"

# step 2: check token
[ -z "$GHCR_TOKEN" ] && fail "GHCR_TOKEN not set. Run with: GHCR_TOKEN=your-token bash install-ai.sh"
ok "GHCR token found"

# step 3: login to GHCR
info "Logging into GHCR..."
echo "$GHCR_TOKEN" | docker login ghcr.io -u tooljet-client --password-stdin \
  && ok "Logged into GHCR" \
  || fail "GHCR login failed. Check your token."

# step 4: download compose file if not present
info "Checking for existing ToolJet setup..."
if [ ! -f "docker-compose.yaml" ] && [ ! -f "docker-compose.yml" ]; then
  info "No existing compose file found. Downloading ToolJet setup..."
  curl -sSL https://raw.githubusercontent.com/ToolJet/ToolJet/main/deploy/docker/docker-compose.yaml \
    -o docker-compose.yaml && ok "Downloaded docker-compose.yaml"
  
  # create default .env if missing
  if [ ! -f ".env" ]; then
    info "Creating default .env file..."
    cat > .env << 'ENVEOF'
TOOLJET_HOST=http://localhost:80
LOCKBOX_MASTER_KEY=changeme_lockbox_key
SECRET_KEY_BASE=changeme_secret_key
TOOLJET_DB_USER=tooljet
TOOLJET_DB_PASS=tooljet
TOOLJET_DB_HOST=postgres
TOOLJET_DB_NAME=tooljet_db
PG_DB=tooljet_db
PG_USER=tooljet
PG_PASS=tooljet
PG_HOST=postgres
ENVEOF
    ok "Created .env file"
  fi
else
  ok "Existing ToolJet setup found"
fi

# step 5: download ai compose file
info "Downloading AI services..."
curl -sSL https://raw.githubusercontent.com/athulya-cloud/tooljet-ai-demo/main/docker-compose.ai.yml \
  -o docker-compose.ai.yml && ok "Downloaded docker-compose.ai.yml"

# step 6: start everything
info "Starting all services..."
docker compose -f docker-compose.yaml -f docker-compose.ai.yml up -d \
  && ok "All services started!" \
  || fail "Failed to start services."

# step 7: health check
info "Waiting for services to be ready..."
sleep 5
curl -sf http://localhost:8080 >/dev/null \
  && ok "AI Server is healthy!" \
  || info "AI Server still starting up — check http://localhost:8080 in a moment"

echo ""
echo "========================================"
echo "  ToolJet      → http://localhost:80"
echo "  AI Server    → http://localhost:8080"
echo "  Neo4j        → http://localhost:7474"
echo "========================================"
echo ""
