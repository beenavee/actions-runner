FROM --platform=$BUILDPLATFORM ghcr.io/actions/actions-runner:latest

ENV MOCKERY_BINARY_VER=2.50.4 MUTAGEN_VERSION=0.18.0

RUN sudo apt-get update && sudo apt-get install -y ansible-core wget ca-certificates curl \
    && sudo install -m 0755 -d /etc/apt/keyrings \
    && sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc \
    && sudo chmod a+r /etc/apt/keyrings/docker.asc \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null \
    && sudo apt-get update && sudo apt-get install -y docker-ce-cli \
    && sudo rm -rf /var/lib/apt/lists/* \
    && sudo apt-get clean \
    && sudo apt-get autoremove -y

RUN cd /tmp \
    && wget https://github.com/vektra/mockery/releases/download/v${MOCKERY_BINARY_VER}/mockery_${MOCKERY_BINARY_VER}_Linux_x86_64.tar.gz \
    && tar -xvf mockery_${MOCKERY_BINARY_VER}_Linux_x86_64.tar.gz \
    && rm -f mockery_${MOCKERY_BINARY_VER}_Linux_x86_64.tar.gz \
    && sudo mv mockery /usr/local/bin/ \
    && sudo chmod +x /usr/local/bin/mockery

RUN cd /tmp \
    && wget https://github.com/mutagen-io/mutagen/releases/download/v${MUTAGEN_VERSION}/mutagen_linux_amd64_v${MUTAGEN_VERSION}.tar.gz \
    && tar -xzf mutagen_linux_amd64_v${MUTAGEN_VERSION}.tar.gz \
    && sudo mv mutagen /usr/local/bin \
    && sudo chmod +x /usr/local/bin/mutagen \
    && rm -f mutagen_linux_amd64_v${MUTAGEN_VERSION}.tar.gz \
    \
    && cd /tmp \
    && wget https://github.com/mutagen-io/mutagen-compose/releases/download/v${MUTAGEN_VERSION}/mutagen-compose_linux_amd64_v${MUTAGEN_VERSION}.tar.gz \
    && tar -xzf mutagen-compose_linux_amd64_v${MUTAGEN_VERSION}.tar.gz \
    && sudo mv mutagen-compose /usr/local/bin \
    && sudo chmod +x /usr/local/bin/mutagen-compose \
    && rm -f mutagen-compose_linux_amd64_v${MUTAGEN_VERSION}.tar.gz
