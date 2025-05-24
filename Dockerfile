FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies, Python, and basic tools
RUN apt update && \
    apt install -y python3 python3-pip curl vim net-tools iputils-ping && \
    apt clean

# Create a non-root user
RUN useradd -ms /bin/bash render && \
    echo "render ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Set working directory
WORKDIR /home/render

# Switch to non-root user
USER render

# Start a simple web server to keep the container alive
CMD ["python3", "-m", "http.server", "10000"]

