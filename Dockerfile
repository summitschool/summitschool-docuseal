# Dockerfile for DocuSeal with data seeding support
# Use this on Railway for the DocuSeal service so the tar + dump are available inside the container.

FROM docuseal/docuseal:latest

# Copy migration assets into the image
COPY docuseal-attachments.tar.gz /app/
COPY docuseal-db-dump.sql /app/
COPY restore-data.sh /app/
RUN chmod +x /app/restore-data.sh

# Optional: run the restore script on startup if the volume is empty.
# DocuSeal image uses a certain entrypoint; we can override or run as init.
# For simplicity, document running it manually or via a side process.
# A common pattern is to call it from an init container or one-time job.

# The main app still starts as normal.
# On Railway: attach volume at /data/docuseal
# You can exec into the running container or use Railway's one-off commands to run the restore script.

CMD ["sh", "-c", "/app/restore-data.sh && /usr/bin/docker-entrypoint.sh"]
