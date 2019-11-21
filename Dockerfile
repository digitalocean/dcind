# Inspired by https://github.com/mumoshu/dcind
FROM ubuntu:18.04

ENV DOCKER_VERSION=18.09.8 \
    DOCKER_COMPOSE_VERSION=1.24.1 \
    PATH=${PATH}:/usr/local/go/bin

# Install Docker and Docker Compose
RUN apt-get update -y && apt-get install -y curl build-essential iptables python3-pip git && \
    curl https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz | tar zx && \
    mv /docker/* /bin/ && \
    chmod +x /bin/docker* && \
    pip3 install docker-compose==${DOCKER_COMPOSE_VERSION} && \
    curl https://dl.google.com/go/go1.13.4.linux-amd64.tar.gz | tar xzf - -C /usr/local && \
    rm -rf /var/lib/apt/lists/*

# Include functions to start/stop docker daemon
COPY docker-lib.sh /docker-lib.sh
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/bash"]
