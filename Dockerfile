FROM docuseal/docuseal:latest

COPY docuseal-attachments.tar.gz /tmp/
RUN chmod 644 /tmp/docuseal-attachments.tar.gz

# Copy the restore script so it's available later
COPY restore-data.sh /app/restore-data.sh
RUN chmod +x /app/restore-data.sh

# Do NOT override CMD or ENTRYPOINT
# Let the official Docuseal image start normally
