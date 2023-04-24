FROM ghcr.io/turbot/steampipe:latest

# Install necessary packages
RUN apt-get update && \
    apt-get install -y curl && \
    curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && \
    apt-get install -y nodejs

# Copy the shell script into the container
COPY entrypoint.sh /entrypoint.sh

# Set the shell script as the entrypoint and make it executable
ENTRYPOINT ["/entrypoint.sh"]
RUN chmod +x /entrypoint.sh
