# Semaphore DevOps Docker Image

Dieses Repository enthält ein Docker-Image für Semaphore DevOps, das regelmäßig gebaut und auf GitHub Container Registry gepusht wird.

## Features

- Ubuntu-basiertes Image
- Enthält Semaphore (v2.9.75) für Ansible Web UI
- Ansible und ansible-lint vorinstalliert
- SSH-Server für Remote-Zugriff
- Supervisor für Prozessmanagement (SSH + Semaphore)
- Umfassende DevOps-Tools: git, curl, wget, nmap, htop, vim, etc.
- Python 3 mit wichtigen Bibliotheken für Ansible
- Automatischer wöchentlicher Build

## Verwendung

```bash
docker pull ghcr.io/florian-asche/semaphore_devops:latest
docker run -d --name semaphore-devops -p 22:22 -p 3000:3000 ghcr.io/florian-asche/semaphore_devops:latest
```

## Build

Das Image wird automatisch wöchentlich gebaut. Sie können es auch manuell bauen:

```bash
docker build -t semaphore-devops .
```

## GitHub Action

Der Build-Prozess wird durch eine GitHub Action gesteuert, die:
- Jeden Sonntag um Mitternacht ausgeführt wird
- Bei Änderungen am Dockerfile oder Workflow ausgelöst wird
- Das Image auf GitHub Container Registry pushed

## Konfiguration

Das Image verwendet Supervisor, um folgende Dienste zu verwalten:
- SSH-Server (Port 22)
- Semaphore Web UI (standardmäßig Port 3000)

## Lizenz

MIT