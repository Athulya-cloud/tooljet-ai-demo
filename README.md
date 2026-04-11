# ToolJet AI — Self-Host Distribution POC

Proves end-to-end private Docker image distribution to self-hosted clients via GHCR.

## Flowdev pushes code →## Flow
dev pushes code → github actions builds image → pushes to GHCR (private) github actions builds image → pushes to GHCR (private)
↓
client pays → we add their github username → they get access
↓
client runs one command → ToolJet + AI server + Neo4j all spin up
↓
contract ends → remove username → access revoked instantly
eof
