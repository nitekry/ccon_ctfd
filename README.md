# CCON CTFd Platform

Custom CTFd deployment with terminal-theme (green phosphor / CRT aesthetic).

**Stack:** CTFd · MariaDB 10.11 · Redis 4 · Nginx

---

## Prerequisites

- Docker Desktop (Mac/Windows) or Docker Engine (Linux)
- Git
- Docker Hub access to `nitekry/ccon_ctfd`

---

## Quickstart

### 1. Clone the Repo
```bash
git clone https://github.com/nitekry/ccon_ctfd
cd ccon_ctfd
```

### 2. Set Up Environment
```bash
cp .env.example .env
nano .env    # set your passwords
```

### 3. Pull the Image
```bash
docker pull nitekry/ccon_ctfd:v2.0
```

### 4. Start the Stack
```bash
# Start DB and cache first
docker compose up -d db cache

# Wait for MariaDB to initialize
sleep 10

# Load the database
docker exec -i $(docker ps --filter "ancestor=mariadb:10.11" --format "{{.Names}}") \
  mysql -u root -p$(grep MARIADB_ROOT_PASSWORD .env | cut -d= -f2) ctfd < db/init.sql

# Bring up the rest
docker compose up -d
```

### 5. Restore Challenge Uploads
```bash
docker cp ./uploads/. $(docker ps --filter "ancestor=nitekry/ccon_ctfd:v2.0" --format "{{.Names}}" | head -1):/var/uploads/
```

### 6. Apply Theme (Required)
```bash
docker cp ./themes/terminal-theme/. \
  $(docker ps --filter "ancestor=nitekry/ccon_ctfd:v2.0" --format "{{.Names}}" | head -1):/opt/CTFd/CTFd/themes/terminal-theme/

docker compose restart ctfd
```
> **Why this step?** Docker named volumes shadow the theme directory at startup.
> The `docker cp` injects the theme files into the running container.
> Hard refresh your browser (`Cmd+Shift+R` / `Ctrl+Shift+R`) after restart.

### 7. Verify
Open your browser to:
- `http://localhost` — public-facing site
- `http://localhost:8000` — direct CTFd (bypasses nginx)

---

## Container Names

Container names vary by OS. Always check with:
```bash
docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}"
```

| Service | Image |
|---|---|
| CTFd app | `nitekry/ccon_ctfd:v2.0` |
| Database | `mariadb:10.11` |
| Cache | `redis:4` |
| Proxy | `nginx:stable` |

---
