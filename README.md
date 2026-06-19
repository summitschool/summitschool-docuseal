# summitschool-docuseal

Clean Railway-ready setup for the DocuSeal instance used by Summit Church School (enroll.summitchurchschool.org).

## Contents
- `docker-compose.yml` - Reference compose (cleaned, no Traefik). Use for local testing.
- `Dockerfile` - Image that includes data migration assets.
- `restore-data.sh` - Script to seed attachments into the volume.
- `docuseal-attachments.tar.gz` + `docuseal-db-dump.sql` - Your preserved data (from local server).
- `.env.railway.example` - Variables to set in Railway.
- `RESTORE-INSTRUCTIONS.md` - Step-by-step for DB + files on Railway.

## Railway Deployment (Recommended)

1. Connect this GitHub repo (`summitschool-docuseal`) as a new **Docker** service in your Railway project.

2. Create linked services:
   - Postgres (Railway Postgres addon)
   - Redis (Railway Redis addon)

3. Attach a **Volume** to the DocuSeal service, mount path: `/data/docuseal`

4. Set environment variables (see `.env.railway.example`):
   - `DATABASE_URL` (from the Postgres service)
   - `REDIS_URL` (from the Redis service)
   - `HOST` = your public URL or custom domain (e.g. `enroll.summitchurchschool.org`)
   - `SECRET_KEY_BASE` (keep the same value)

5. Deploy.

6. Run data restore (see `RESTORE-INSTRUCTIONS.md`).

## Local Testing

```bash
docker compose up --build
# Visit http://localhost:3000
```

## Data

The attached tar and dump are from the original local server migration (June 2026).

After successful restore on Railway you can delete the large files from the repo if desired to keep the repo light.

## Notes
- The original local setup used Traefik for the subdomain. Railway handles TLS and domains for you.
- Use custom domains in the Railway dashboard to keep `enroll.summitchurchschool.org`.
