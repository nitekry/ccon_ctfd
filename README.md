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
docker pull nitekry/ccon_ctfd:v2.1
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
docker cp ./uploads/. $(docker ps --filter "ancestor=nitekry/ccon_ctfd:v2.1" --format "{{.Names}}" | head -1):/var/uploads/
```

### 6. Apply Theme (Required)
```bash
docker cp ./themes/terminal-theme/. \
  $(docker ps --filter "ancestor=nitekry/ccon_ctfd:v2.1" --format "{{.Names}}" | head -1):/opt/CTFd/CTFd/themes/terminal-theme/

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
| CTFd app | `nitekry/ccon_ctfd:v2.1` |
| Database | `mariadb:10.11` |
| Cache | `redis:4` |
| Proxy | `nginx:stable` |

---

## Making Changes

### Theme / Plugin Updates
1. Edit files in `./themes/` or `./plugins/`
2. Rebuild and push:
```bash
docker build -t nitekry/ccon_ctfd:v2.x .
docker push nitekry/ccon_ctfd:v2.x
```
3. Update version in `docker-compose.yml`
4. Commit and push to GitHub

### Database Changes
```bash
# Export current state
docker exec <db_container> mysqldump -u root -pctfd ctfd > db/init.sql
git add db/init.sql
git commit -m "chore: update db dump"
git push
```

### Challenge File Updates
```bash
docker cp <ctfd_container>:/var/uploads/. ./uploads/
git add uploads/
git commit -m "chore: update uploads"
git push
```

---

## Teardown
```bash
# Stop stack (preserves volumes)
docker compose down

# Stop and wipe all data (full reset)
docker compose down -v
```

---

## Troubleshooting

| Symptom | Fix |
|---|---|
| Theme loads but unstyled | Re-run Step 6 (docker cp theme), hard refresh browser |
| DB connection error | Wait longer after `docker compose up -d db` before loading SQL |
| Port 80 blocked on Mac | Change nginx port to `8080:80` in `docker-compose.yml` |
| M1/M2/M3 image won't start | Add `platform: linux/amd64` under `ctfd:` in compose |
| Wrong container name | Run `docker ps` and substitute actual name |
| Uploads missing | Re-run Step 5 with correct container name from `docker ps` |
EOF
