# Easypanel Production Deployment Plan
## OMP Website → DockerHub → Easypanel

---

## Current State Analysis

| Component | Status | Detail |
|---|---|---|
| **Dockerfile** | ✅ Ready | Multi-stage, Ruby 3.3.11, Thruster (port 80) |
| **Entrypoint** | ✅ Ready | Auto-runs `db:prepare` on boot |
| **database.yml** | ⚠️ Needs env vars | Production uses `NEWOMP_DATABASE_PASSWORD` + `DATABASE_URL` |
| **Credentials** | ✅ Has `credentials.yml.enc` | Needs `RAILS_MASTER_KEY` env var |
| **master.key** | ❌ Missing locally | Must create or recover |
| **Active Storage** | ⚠️ Local disk | 13MB files in `storage/` — needs volume mount |
| **CSS Build** | ✅ Built in Dockerfile | `assets:precompile` runs in build stage |
| **Production DBs** | ⚠️ 4 databases | Primary + cache + queue + cable (Solid Queue/Cache) |

---

## Architecture on Easypanel

```mermaid
graph LR
    A[Internet] --> B[Easypanel Proxy<br/>SSL/HTTPS]
    B --> C[App Service<br/>DockerHub Image<br/>Port 80]
    C --> D[PostgreSQL Service<br/>Managed DB]
    C --> E[Volume: storage<br/>Active Storage files]
```

---

## Step-by-Step Deployment

### Phase 1: Build & Push Docker Image

```bash
# 1. Build production image
docker build -t tradex367/omp-website:latest .

# 2. Tag with version
docker tag tradex367/omp-website:latest tradex367/omp-website:v1.0

# 3. Push to DockerHub
docker login
docker push tradex367/omp-website:latest
docker push tradex367/omp-website:v1.0
```

### Phase 2: Easypanel Setup

#### 2a. Create Project
- Log in to Easypanel dashboard
- Create a new **Project**: `omp-website`

#### 2b. Add PostgreSQL Service
- Add service → **Postgres**
- Name: `omp-db`
- Version: PostgreSQL 16
- Database name: `newomp_production`
- Username: `newomp`
- Set a strong password
- Note the internal hostname (usually `omp-db`)

#### 2c. Add App Service
- Add service → **App**
- Name: `omp-app`
- Source: **Docker Image**
- Image: `tradex367/omp-website:latest`
- Port: `80`

#### 2d. Configure Environment Variables

| Variable | Value | Required |
|---|---|---|
| `RAILS_ENV` | `production` | ✅ |
| `RAILS_MASTER_KEY` | *(from config/master.key)* | ✅ |
| `DATABASE_URL` | `postgres://newomp:<password>@omp-db:5432/newomp_production` | ✅ |
| `NEWOMP_DATABASE_PASSWORD` | *(same db password)* | ✅ |
| `RAILS_SERVE_STATIC_FILES` | `true` | ✅ |
| `RAILS_LOG_TO_STDOUT` | `true` | ✅ |
| `SECRET_KEY_BASE` | *(generate with `rails secret`)* | ⚠️ Fallback |

> [!IMPORTANT]
> The `DATABASE_URL` env var will override the `database.yml` production config.
> This means you only need **one** PostgreSQL database — Rails will use it for primary, and Solid Cache/Queue will use the same DB.

#### 2e. Add Volume Mount
- Mount path: `/rails/storage`
- This persists Active Storage uploads between deployments

#### 2f. Configure Domain
- Add your domain (e.g., `app.openmindprojects.org`)
- Enable HTTPS (Easypanel handles Let's Encrypt automatically)

### Phase 3: Database Migration

After the app service is running:

```bash
# Option A: Import the SQL dump via Easypanel terminal
psql -U newomp -d newomp_production -f newomp_production_ready.sql

# Option B: Let Rails create fresh schema (if no seed data needed)
# The entrypoint already runs db:prepare automatically
```

### Phase 4: Upload Storage Files

```bash
# Tar the local storage directory
tar czf storage_backup.tar.gz storage/

# Upload to the Easypanel volume via SCP or the Easypanel file manager
```

---

## Required Pre-Deployment Fixes

### 1. Generate or Recover `master.key`

```bash
# If you have the key, create the file:
echo "your-master-key-here" > config/master.key

# If lost, regenerate credentials:
rm config/credentials.yml.enc
EDITOR="nano" bin/rails credentials:edit
# This creates a new master.key + credentials.yml.enc
```

### 2. Simplify Production Database Config

The current `database.yml` production config expects 4 separate databases (primary, cache, queue, cable). For Easypanel with a single PostgreSQL instance, we should simplify:

```yaml
production:
  <<: *default
  url: <%= ENV["DATABASE_URL"] %>
```

> [!NOTE]
> Solid Cache and Solid Queue can share the primary database. The separate databases are optional and only beneficial at scale.

### 3. Set `config.hosts` for Production

In `config/environments/production.rb`, uncomment and set:
```ruby
config.hosts = [
  "app.openmindprojects.org",
  /.*\.openmindprojects\.org/
]
config.host_authorization = { exclude: ->(request) { request.path == "/up" } }
```

### 4. Enable Force SSL

```ruby
config.assume_ssl = true
config.force_ssl = true
config.ssl_options = { redirect: { exclude: ->(request) { request.path == "/up" } } }
```

---

## Environment Variables Checklist

| Variable | Source | Example |
|---|---|---|
| `RAILS_MASTER_KEY` | `config/master.key` | `abc123def456...` |
| `DATABASE_URL` | Easypanel Postgres | `postgres://newomp:pass@omp-db:5432/newomp_production` |
| `RAILS_ENV` | Hardcoded | `production` |
| `RAILS_SERVE_STATIC_FILES` | Hardcoded | `true` |
| `RAILS_LOG_TO_STDOUT` | Hardcoded | `true` |

---

## Post-Deploy Verification

- [ ] `https://yourdomain.com/up` returns 200 (health check)
- [ ] `https://yourdomain.com/admin` loads the login page
- [ ] Admin login works with existing credentials
- [ ] Projects index page loads with data
- [ ] Active Storage images display correctly
- [ ] Gallery uploads work from admin panel
