FROM python:3.11-slim

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install Deluge, libtorrent, and dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        deluged \
        deluge-web \
        python3-libtorrent \
        python3-gi \
        python3-mako \
        python3-chardet \
        ca-certificates \
        locales \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

EXPOSE 58846 8112
VOLUME ["/config"]

CMD ["deluge-web", "-c", "/config"]