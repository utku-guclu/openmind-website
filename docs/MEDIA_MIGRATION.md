# Media migration — off WordPress, onto self-owned storage

## Why
The Rails 8 app replaces the live WordPress site at openmindprojects.org. Before handover to the coworker, all media references must stop depending on the WP installation (which is on a server we don't fully control, behind Cloudflare's cache). Without this, the new app would break the day WP gets decommissioned.

## End state
- Active Storage backed by **Cloudflare R2** (S3-compatible, generous free tier, zero egress).
- Local dev defaults to disk; flip to R2 by setting `STORAGE_SERVICE=amazon` in `.env`.
- Production defaults to `:amazon`.
- Both devs and prod read/write the same R2 bucket — no per-machine media isolation.

## Phase status

### Phase 1 — Placeholder swap and Rails wiring (DONE, commit `9d50a52`)
- Every WP image URL across `db/seeds.rb`, `db/seed_data/volunteer_audiences.rb`, and 4 view partials replaced with `placehold.co` URLs (colored, labeled by purpose).
- `db/seed_assets/placeholder_gallery.jpg` (15 KB) bundled in repo, attached to each `Project#image` in `db/seeds.rb` so index/show views render.
- Dead `db/seeds/project_gallery_images.rb` deleted — referenced a non-existent `Project#gallery_images` association.
- `config/storage.yml` has an `amazon:` block using R2 endpoint + ENV-based creds.
- `Gemfile` includes `aws-sdk-s3` (with `require: false`).
- `config/environments/{development,production}.rb` read `STORAGE_SERVICE` env var.
- `.env.example` documents `STORAGE_SERVICE`, `R2_ACCESS_KEY_ID`, `R2_SECRET_ACCESS_KEY`, `R2_ENDPOINT`, `R2_BUCKET`.
- Stray SQL dumps moved to `_backups/` (gitignored); `db/*.sql` also gitignored.

### Phase 2 — Create R2 bucket and connect (TODO)
Owner: Utku (this account). Steps:
1. Sign in at https://dash.cloudflare.com → R2 Object Storage → "Create bucket". Name: `omp-media` (or chosen). Region: leave default; R2 routes automatically.
2. R2 → "Manage R2 API Tokens" → "Create API Token":
   - Permissions: **Object Read & Write**
   - Specify bucket: scope to `omp-media`
   - TTL: no expiry (or 1 year, your call)
   - Copy the **Access Key ID**, **Secret Access Key**, and the **S3 API endpoint** (format: `https://<account_id>.r2.cloudflarestorage.com`).
3. In a local `.env` (gitignored), set:
   ```
   STORAGE_SERVICE=amazon
   R2_ACCESS_KEY_ID=...
   R2_SECRET_ACCESS_KEY=...
   R2_ENDPOINT=https://<account_id>.r2.cloudflarestorage.com
   R2_BUCKET=omp-media
   ```
4. Restart Rails. Upload a test image via ActiveAdmin (any model with an attachment — TeamMember, Project, VolunteerAudience). Confirm it appears in the R2 dashboard.
5. Once verified: share the four `R2_*` values with the coworker out-of-band (1Password / Bitwarden / Signal — **not** git, not email plain text).

### Phase 3 — Handover (TODO, after Phase 2)
Coworker clones, runs `bin/rails db:create db:migrate db:seed` → placeholders everywhere. He uploads real photos via ActiveAdmin. Because both `.env` files point at the same R2 bucket, uploads are shared automatically.

### Phase 4 — Shared database (DECISION DEFERRED)
Active Storage solves *media* sharing. The actual DB rows (text content edited via admin) still live on each developer's local Postgres. Options when this starts to hurt:
- **Periodic `pg_dump` exchange** — zero cost, low-frequency edits.
- **Neon free tier** — shared dev Postgres, both `DATABASE_URL`s point at it.
- **Coworker owns prod content, you own code** — only one of you edits DB.

No decision needed until content drift becomes a real friction.

## Conventions established by this work
- **Two image patterns** coexist:
  - String URL columns (e.g. `Destination#hero_image_url`, `VolunteerAudience#hero_image`) for cases where the value is a URL to render directly. Placeholders use `placehold.co`.
  - Active Storage attachments (`has_one_attached :image` etc.) for admin-managed uploads. Placeholders attach `db/seed_assets/placeholder_gallery.jpg`.
- **Adding a new image field** should prefer Active Storage so the admin can swap it. Use string URL columns only when the source is an external system you don't want to mirror.
- **Never commit real photographs** to git. Active Storage + R2 is the path; `db/seed_assets/` is for tiny illustrative placeholders only.

## What is **explicitly out of scope**
- Mirroring the existing WP photo library into R2. Decision (2026-05-20): not worth it — coworker will upload fresh, current content via admin.
- Backwards compatibility with WP URLs. Once removed, nothing in the app should ever fetch from `openmindprojects.org/wp-content/...` again.
