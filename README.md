# ToolJet AI — Distribution POC

Proves that a private Docker image can be securely distributed to self-hosted clients via GHCR.

## What's Built
- `server.js` + `Dockerfile` — fake AI server (placeholder for real ai-server)
- `docker-compose.ai.yml` — spins up ai-server + neo4j alongside ToolJet
- `install-ai.sh` — one command client installer
- `publish.yml` — github actions auto-builds + pushes image to GHCR on every push

## How Client Access Works
each client gets invited via their github username → generates their own token → runs install script → contract ends → revoked instantly

## How to Run
```bash
GHCR_TOKEN="your-token" bash install-ai.sh
```
