# DocuSeal Data Restore on Railway

## 1. Database Restore (Postgres)

After your Postgres service is running on Railway:

```bash
# Get your connection string from Railway (use the public one for initial restore, or private if on same project)
# Example:
psql "postgresql://postgres:password@host:port/docuseal" < docuseal-db-dump.sql
```

Or using Railway CLI (preferred):

```bash
railway run --service your-postgres-service psql < docuseal-db-dump.sql
```

## 2. File Attachments Restore

The attachments live in the persistent Volume mounted at `/data/docuseal`.

Options:

**A. Recommended: Use the seeder script (included in this repo)**

1. Deploy the DocuSeal service using the Dockerfile in this folder (or the image + run the script).
2. After the container is up (with volume attached), exec into it:

```bash
railway run --service docuseal-app sh -c "/app/restore-data.sh"
```

Or use Railway "One-off command" / shell.

The script checks if the dir is empty and extracts the tar.

**B. Manual**

If the volume is attached and empty:

```bash
# Copy the tar into the container or use a sidecar
tar -xzf docuseal-attachments.tar.gz -C /data/docuseal
```

## 3. After Restore

- Restart the DocuSeal app service.
- Log in and verify that all previous templates, submissions, and signed PDFs are present.
- Test creating a new fillable form and signing flow.

## Notes
- The SECRET_KEY_BASE must match what was used when the data was created (or you may have session issues).
- Redis is mainly for background jobs — it can be empty after migration.
- Keep the attachments tar and dump in a safe place (or in the git repo history if you want).
