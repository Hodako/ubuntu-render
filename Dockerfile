FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt update && \
    apt install -y git cmake g++ libjson-c-dev libwebsockets-dev libssl-dev make curl bash && \
    git clone https://github.com/tsl0922/ttyd.git && \
    cd ttyd && mkdir build && cd build && cmake .. && make && make install

# Create a non-root user
RUN useradd -ms /bin/bash render
USER render
WORKDIR /home/render

# Start ttyd on port 10000
CMD ["ttyd", "-p", "10000", "bash"]
