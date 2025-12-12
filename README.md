# bind-dyndns Docker Image

Dieses Repository enthält ein Docker-Image für bind-dyndns, das regelmäßig gebaut und auf GitHub Container Registry gepusht wird.

## Features

- Ubuntu-basiertes Image
- Enthält Cron, dnsutils und curl
- Automatischer wöchentlicher Build
- Optimiert für DNS-Dienste

## Verwendung

```bash
docker pull ghcr.io/florian-asche/bind-dyndns:latest
docker run -d --name bind-dyndns ghcr.io/florian-asche/bind-dyndns:latest
```

## Build

Das Image wird automatisch wöchentlich gebaut. Sie können es auch manuell bauen:

```bash
docker build -t bind-dyndns .
```

## GitHub Action

Der Build-Prozess wird durch eine GitHub Action gesteuert, die:
- Jeden Sonntag um Mitternacht ausgeführt wird
- Bei Änderungen am Dockerfile oder Workflow ausgelöst wird
- Das Image auf GitHub Container Registry pushed

## Lizenz

MIT