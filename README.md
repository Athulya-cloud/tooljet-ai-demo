# ToolJet AI — Self-Host Distribution POC

Proves end-to-end private Docker image distribution to self-hosted clients via GHCR.

## Flow

```
dev pushes code
        ↓
github actions builds image + pushes to GHCR (private)
        ↓
client pays → we add their github username
        ↓
client runs one command → ToolJet + AI server + Neo4j spin up
        ↓
contract ends → remove username → access revoked instantly
```

## What is Built
- server.js + Dockerfile — fake AI server (placeholder for real ai-server)
- docker-compose.ai.yml — adds ai-server + neo4j to existing ToolJet
- install-ai.sh — one command installer (handles login, download, setup, health check)
- publish.yml — auto-builds and pushes to GHCR on every push

## Client Setup
```bash
GHCR_TOKEN="your-token" bash install-ai.sh
```

## Per-Client Access
each client = own github username = own token = independent revocation
