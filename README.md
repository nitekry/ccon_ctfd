# CCON CTFd Platform

Custom CTFd deployment with terminal-theme

**Stack:** CTFd · MariaDB 10.11 · Redis 4 · Nginx

---

## Prerequisites

- Docker Desktop (Mac/Windows) or Docker Engine (Linux/Pi)
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
# Start the full stack
docker compose up -d

# Watch until CTFd is ready (look for gunicorn booting)
docker compose logs -f ctfd
# Press Ctrl+C once you see: [INFO] Booting worker with pid
```

### 5. Run the Setup Wizard
Open your browser to:
- `http://localhost` — public-facing site (via nginx)
- `http://localhost:8000` — direct CTFd (bypasses nginx)

Complete the CTFd setup wizard:
- Set admin username, email, and password
- Set CTF name and format
- Click **Finish**

### 6. Apply Theme (Required)
```bash
docker cp ./themes/terminal-theme/. \
  $(docker ps --filter "ancestor=nitekry/ccon_ctfd:v2.0" --format "{{.Names}}" | head -1):/opt/CTFd/CTFd/themes/terminal-theme/

docker compose restart ctfd
```
> **Why this step?** Docker named volumes shadow the theme directory at startup.
> The `docker cp` injects the theme files into the running container.
> Hard refresh your browser (`Cmd+Shift+R` / `Ctrl+Shift+R`) after restart.

Then go to **Admin → Config → Theme** and select `terminal-theme`.

### 7. Restore Challenge Uploads (Optional)
Only needed if restoring from an existing deployment:
```bash
docker cp ./uploads/. \
  $(docker ps --filter "ancestor=nitekry/ccon_ctfd:v2.0" --format "{{.Names}}" | head -1):/var/uploads/
```

### 8. Import Challenges (Optional)
To restore challenges from a previous CTFd instance:
1. On the **source** CTFd: **Admin → Export** → download the `.zip`
2. On the **new** CTFd: **Admin → Import** → upload the `.zip`

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

## Making Changes

### Theme / Plugin Updates
1. Edit files in `./themes/` or `./plugins/`
2. Rebuild with a bumped version tag:
```bash
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  -t nitekry/ccon_ctfd:vX.X \
  --push .
```
3. Update the version tag in `docker-compose.yml` and this README
4. Commit and push to GitHub

### Challenge File Updates
```bash
# Pull uploads out of running container
docker cp \
  $(docker ps --filter "ancestor=nitekry/ccon_ctfd:v2.0" --format "{{.Names}}" | head -1):/var/uploads/. \
  ./uploads/

git add uploads/
git commit -m "chore: update uploads"
git push
```

---

## Teardown
```bash
# Stop stack (preserves data volumes)
docker compose down

# Full reset — wipes ALL data
docker compose down -v
```

---

## Troubleshooting

| Symptom | Fix |
|---|---|
| Theme loads but unstyled | Re-run Step 6, hard refresh browser (`Cmd+Shift+R`) |
| Site not reachable on Pi | Use Pi's IP address instead of `localhost` |
| Port 80 blocked on Mac | Change nginx port to `8080:80` in `docker-compose.yml` |
| M1/M2/M3 image won't start | Add `platform: linux/amd64` under `ctfd:` in compose |
| Wrong container name | Run `docker ps` and substitute actual name |
| Uploads missing | Re-run Step 7 with correct container name from `docker ps` |
| CTFd crash loop on startup | Run `docker compose down -v` then `docker compose up -d` for a clean slate |
