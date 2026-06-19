FROM docuseal/docuseal:latest

# Copy only the restore script (data is restored via volume + one-off command)
COPY restore-data.sh /app/
RUN chmod +x /app/restore-data.sh

# Let the official Docuseal image handle startup normally
# We will run the restore script manually after first deploy
CMD ["sh", "-c", "/usr/bin/docker-entrypoint.sh"]
