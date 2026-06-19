#!/bin/sh
# restore-data.sh
# Run this (or as part of container entrypoint) after the volume is mounted.
# It restores the DB (if needed) and extracts attachments if the volume looks empty.

set -e

DATA_DIR="/data/docuseal"
ATTACHMENTS_TAR="/app/docuseal-attachments.tar.gz"
DB_DUMP="/app/docuseal-db-dump.sql"

echo "DocuSeal data restore script starting..."

# Ensure data dir exists
mkdir -p "$DATA_DIR"

# Seed attachments if the dir is empty (first run on new volume)
if [ ! "$(ls -A $DATA_DIR 2>/dev/null)" ]; then
  echo "Volume appears empty — extracting attachments..."
  if [ -f "$ATTACHMENTS_TAR" ]; then
    tar -xzf "$ATTACHMENTS_TAR" -C "$DATA_DIR"
    echo "Attachments restored."
  else
    echo "No attachments tar found at $ATTACHMENTS_TAR"
  fi
else
  echo "Attachments directory already has content — skipping extract."
fi

# Note: DB restore is usually done once from outside (using psql + DATABASE_URL)
# Example (run from your machine with Railway CLI or connection string):
#   psql "$DATABASE_URL" < docuseal-db-dump.sql

echo "DocuSeal data restore script finished."
echo "If this is the first run, make sure you have restored the Postgres database separately."
