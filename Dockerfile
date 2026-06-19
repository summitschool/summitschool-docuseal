FROM docuseal/docuseal:latest

# Copy the restore script so it's available later
COPY restore-data.sh /app/restore-data.sh
RUN chmod +x /app/restore-data.sh

# Do NOT override CMD or ENTRYPOINT
# Let the official Docuseal image start normally
