FROM ghcr.io/turbot/steampipe:latest

USER root:0

# Install necessary packages
RUN apt update
RUN apt-get update -y && apt-get install -y git curl
RUN curl -fsSL https://deb.nodesource.com/setup_current.x | bash -
RUN apt install -y nodejs

# Copy the shell script into the container
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

USER steampipe:0

# Set the shell script as the entrypoint and make it executable
ENTRYPOINT ["/entrypoint.sh"]
