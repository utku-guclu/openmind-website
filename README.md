# OpenMind Projects

Rails 8 monolith for **openmindprojects.org** — server-rendered with ERB + Hotwire (Turbo + Stimulus), backed by PostgreSQL 16 with the TimescaleDB extension. Brand identity ported from the OpenMind Projects visual system (`theme/AI_CODEX_BRAND_GUIDE.md`).

- **Stack:** Ruby 3.3.11 · Rails 8.1 · PostgreSQL 16 + TimescaleDB · Hotwire (Turbo + Stimulus) · Importmap · Propshaft
- **Persistence:** Solid Queue (jobs) · Solid Cache (cache) · Solid Cable (websockets) — all DB-backed, no Redis
- **Search & SEO:** `pg_search` for full-text, `pagy` for pagination, `meta-tags` for SEO
- **Auth:** `bcrypt` on `AdminUser` (admin UI lands in Phase 4)
- **Storage:** Active Storage with `image_processing` (libvips)
- **Deploy:** Kamal + Thruster (configured under `.kamal/`)

## Quick start

```bash
# 1. Bring up Postgres (TimescaleDB on :5433 to avoid colliding with system pg)
docker compose up -d

# 2. Install gems
bundle install

# 3. Create + migrate + seed
bin/rails db:prepare

# 4. Boot the app
bin/rails server          # http://localhost:3000
```

The seed prints the admin credentials on first run (default: `admin@openmindprojects.org / changeme123`).

## Admin

A full role-based admin UI lives at **`/admin`** (ActiveAdmin + Devise + CanCanCan).

```
http://localhost:3000/admin/login
  email:    admin@openmindprojects.org
  password: changeme123
```

What you get out of the box:

- **Login screen** (Devise) with "remember me" and password reset
- **Dashboard** (`/admin`) — recent volunteer applications, recent contact messages, draft posts, content counts; superadmins also see an Admin Users panel
- **CRUD screens** for all 10 models — Projects, Destinations, Posts, Partners, Team Members, Testimonials, Site Settings, Volunteer Applications, Contact Messages, Admin Users
- **Filters / search / CSV export** on every index page (via Ransack)
- **Role-based access** via CanCanCan:

  | Role         | Can do                                                  |
  | ------------ | -------------------------------------------------------- |
  | `superadmin` | Everything, including create/delete other admin users    |
  | `admin`      | Manage all content; read Admin Users but not modify them |
  | `editor`     | Create + edit their own posts; read other content        |

To create another admin user: log in as superadmin → Admin Users → New, set role and password.

> **Phase 2:** Trix WYSIWYG editor on rich-text fields (currently Post body / Project description / Team Member bio are plain HTML textareas).

## Routes

| Path | Controller#action |
| --- | --- |
| `/` | `pages#home` |
| `/about` | `pages#about` |
| `/volunteer` | `pages#volunteer` |
| `/research-development` | `pages#research` |
| `/projects`, `/projects/:slug` | `projects#index`, `projects#show` |
| `/destinations`, `/destinations/:slug` | `destinations#index`, `destinations#show` |
| `/apply/new`, `POST /apply` | `applications#new`, `applications#create` |
| `/contact/new`, `POST /contact` | `contacts#new`, `contacts#create` |
| `/donate` | `302 → https://fundhub.openskills.dev/` |
| `/up` | Rails health check |
| `/manifest`, `/service-worker` | PWA manifest + service worker |

`/news` (Posts) and `/admin` are scaffolded in the model layer and ship in later phases — see `IMPLEMENTATION_PLAN.md`.

## Project layout

```
app/
  assets/stylesheets/
    brand.css                 # OpenMind design tokens (palette, typography, spacing, shadows)
    application.css           # form + utility styles built on top of brand.css
  controllers/                # PagesController, ProjectsController, DestinationsController,
                              # ApplicationsController, ContactsController
  javascript/
    controllers/              # Stimulus controllers (navbar, reveal, particles, counter, hello)
  models/                     # Project, Destination, Post, AdminUser, VolunteerApplication,
                              # ContactMessage, Partner, TeamMember, Testimonial, SiteSetting
  views/
    layouts/application.html.erb
    pages/{home,about,volunteer,research}.html.erb
    projects/{index,show}.html.erb
    destinations/{index,show}.html.erb
    applications/new.html.erb
    contacts/new.html.erb
    shared/{_navbar,_footer}.html.erb
config/
  routes.rb
  database.yml                # postgres on :5433 (docker), env-driven password
  importmap.rb                # JS pinning (Stimulus, Turbo)
db/
  migrate/                    # destinations, projects, admin_users, team_members, partners,
                              # posts, testimonials, volunteer_applications, site_settings,
                              # contact_messages, analytics_hypertables (TimescaleDB)
  seeds.rb                    # 3 destinations, 7 projects, 11 partners, 12 site settings, admin
theme/
  AI_CODEX_BRAND_GUIDE.md     # palette + typography + voice
  brand_*.png                 # palette / logo / typography reference images
.kamal/                       # deploy config
docker-compose.yml            # TimescaleDB (postgres) on :5433
Dockerfile                    # production image (Kamal-friendly)
IMPLEMENTATION_PLAN.md        # phased roadmap
devplan/IMPLEMENTATION_PLAN.md
```

## Development

| Task | Command |
| ---- | ------- |
| Boot the dev server | `bin/rails server` |
| Run console | `bin/rails console` |
| Reset the DB (drop + create + migrate + seed) | `bin/rails db:reset` |
| Just re-seed | `bin/rails db:seed` |
| Lint Ruby | `bin/rubocop` |
| Static security scan | `bin/brakeman` |
| Audit gems for CVEs | `bin/bundler-audit` |
| Background jobs | `bin/jobs` (Solid Queue worker) |
| Full CI (lint + audits + tests) | `bin/ci` |

## Tests

Three layers, all under `test/`:

```
test/
  models/         # 31 tests — validations, scopes, slug callbacks, typed_value
  controllers/    # 19 integration tests — routes, redirects, flash, error rendering
  system/         # 7 system tests — real Chromium, Capybara + Selenium
  test_helper.rb
  application_system_test_case.rb
```

| What | Command |
| --- | --- |
| **Watch the browser drive the app + see server logs** | `bin/test_full` |
| Just unit + controller (fast, no browser) | `bin/test_full unit` |
| Only system tests (headed) | `bin/test_full system` |
| Headless mode (CI-style) | `HEADLESS=1 bin/test_full` |
| Plain Rails Minitest (no log streaming) | `bin/rails test` |
| One file | `bin/rails test test/models/project_test.rb` |
| One line | `bin/rails test test/models/project_test.rb:10` |

**`bin/test_full`** is the fullstack runner. It:

1. Brings up `docker compose` (TimescaleDB on `:5433`) if it isn't already.
2. Runs `bin/rails db:test:prepare`.
3. Truncates `log/test.log` and starts `tail -f` in the background, prefixing each line with `[server]` so server-side activity streams into your terminal.
4. Runs `bin/rails test` against the chosen scope.
5. Cleans up the tail on exit (Ctrl-C also works).

For system tests, the **browser is visible by default** (`Capybara` driver = `:selenium, using: :chrome`) so you can watch each form fill, click, and navigation. Set `HEADLESS=1` to switch to headless Chrome.

`bin/ci` runs lint + security audits + the full test suite (system tests in headless mode); use it before pushing.

## Brand

All design tokens live in `app/assets/stylesheets/brand.css` as CSS custom properties. Source of truth for colors, typography, voice and spacing is `theme/AI_CODEX_BRAND_GUIDE.md`.

| Token | Value |
| --- | --- |
| `--color-primary` | `#0C7ABF` Deep Ocean Blue |
| `--color-accent` | `#E89B1C` Amber Gold |
| `--color-green` | `#4CAF50` Fresh Green (Development pillar) |
| `--color-cornflower` | `#6B8EC7` (Research pillar) |
| `--color-teal` | `#008B8B` (CTAs) |
| `--font-primary` | Inter |
| `--font-display` | Playfair Display |
| `--font-mono` | Roboto Mono |

## Deploy

Kamal config is in `.kamal/`. Production uses `Dockerfile` (multi-stage, jemalloc, Thruster in front of Puma). See `bin/kamal` and the `kamal` gem docs.

## Phased roadmap

See `IMPLEMENTATION_PLAN.md` and `devplan/IMPLEMENTATION_PLAN.md` for the phased plan. Current state corresponds to Phase 1 (public site + apply/contact forms). Phase 2 adds news/posts, Phase 3 admin UI, Phase 4 analytics dashboards over TimescaleDB.
