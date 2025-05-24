FROM ubuntu:20.04

# Avoid interaction during build
ENV DEBIAN_FRONTEND=noninteractive

# Install basic tools
RUN apt update && \
    apt install -y curl vim net-tools iputils-ping && \
    apt clean

# Create a non-root user
RUN useradd -ms /bin/bash render && \
    echo "render ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Set working directory
WORKDIR /home/render

# Switch to non-root user
USER render

# Start a basic HTTP server (required by Render)
CMD ["bash", "-c", "while true; do echo '<h1>Ubuntu container running on Render</h1>' > index.html; python3 -m http.server 10000; done"]
