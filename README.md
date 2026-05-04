# OpenMind monorepo

Two workspaces, one stack:

- **`openmind-api/`** — Rails 7 API (auth + admin/writes), Postgres 15, PostgREST 12 (public reads), Caddy front door.
- **`openmind-client/`** — React 19 + Vite SPA + Playwright e2e.

The Rails app and PostgREST share the same Postgres and the same `JWT_SECRET`. Caddy fronts both on port 80 and routes by path. See [`openmind-api/README.md`](openmind-api/README.md) for the routing table.

## Run from this directory

| Command           | What it does                                                            |
| ----------------- | ----------------------------------------------------------------------- |
| `make up`         | Build + start Postgres, Rails, PostgREST and Caddy. Waits until healthy.|
| `make down`       | Stop and remove containers (keeps the Postgres volume).                  |
| `make clean`      | Stop and wipe containers **and** volumes.                                |
| `make logs`       | Tail interleaved logs from all four services with prefixes.              |
| `make ps`         | Show stack status.                                                       |
| `make dev`        | Boot the stack and start the Vite dev server (`http://localhost:5173`). |
| `make e2e`        | Boot stack → tail server logs → run **headed** Playwright (watch the browser). |
| `make e2e-ci`     | Same but headless; tears the stack down at the end.                      |

`npm run <target>` works too — the top-level `package.json` proxies to `make`.

### Watching it work locally

`make e2e` is the integrated path the user-facing prompt asked for. While it runs you'll see, in one terminal:

1. **Server logs (prefixed)** from `caddy`, `rails`, `postgrest`, `postgres` streamed via `docker compose logs -f`.
2. **The Playwright runner** printing each spec it executes.
3. **A real Chromium window** opening, navigating, clicking, with `slowMo: 250ms` so each step is observable.

Failures retain a trace + video under `openmind-client/test-results/`.

Stop with `Ctrl-C` — the log stream stops, the docker stack stays up so you can poke around. `make down` to bring it down.

## Architecture in one diagram

```
                ┌─────────────────────────────────────────────────┐
                │ Browser (http://localhost)                       │
                └─────────────────┬───────────────────────────────┘
                                  ▼
                       ┌──────────────────┐
                       │  Caddy (:80)     │  ← single ingress
                       └────┬─────────┬───┘
        /api/v1/auth/*      │         │      /api/v1/* (cookie → Bearer)
        /api/v1/admin/*     │         │
        /rails/*            ▼         ▼
                  ┌─────────────┐  ┌──────────────┐
                  │ Rails       │  │ PostgREST    │
                  │ :3000       │  │ :3000        │
                  │ (auth+admin)│  │ (api schema) │
                  └──────┬──────┘  └──────┬───────┘
                         │                │
                         ▼                ▼
                    ┌────────────────────────┐
                    │     Postgres :5432     │
                    │  public.* (Rails)      │
                    │  api.*    (views/RPCs) │
                    └────────────────────────┘
```

## First-time checklist

```bash
# .env must exist with JWT_SECRET + SECRET_KEY_BASE
ls openmind-api/.env || (cp openmind-api/.env.example openmind-api/.env && \
  echo "JWT_SECRET=$(openssl rand -hex 32)"      >> openmind-api/.env && \
  echo "SECRET_KEY_BASE=$(openssl rand -hex 64)" >> openmind-api/.env)

# Bring everything up and run the headed e2e suite:
make e2e
```
