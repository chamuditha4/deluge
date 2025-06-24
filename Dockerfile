# Use an official Python runtime as a parent image
FROM python:3.11-slim

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        python3-pip \
        python3-gi \
        python3-mako \
        python3-chardet \
        python3-libtorrent \
        ca-certificates \
        locales \
        && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy the Deluge source code into the container
COPY . /app


# Install Deluge and its Python dependencies
RUN pip install .[all]

# Expose Deluge daemon and web UI ports
EXPOSE 58846 8112

# Create a volume for Deluge config/data
VOLUME ["/config"]

# Set the default command to run the Deluge daemon
CMD ["deluged", "-c", "/config", "-d"]
