FROM --platform=$BUILDPLATFORM ghcr.io/actions/actions-runner:latest

ENV MOCKERY_BINARY_VER=2.43.2 MUTAGEN_VERSION=0.17.6

RUN apt-get update && apt-get install -y ansible-core wget \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean \
    && apt-get autoremove -y

RUN cd /tmp \
    && wget https://github.com/vektra/mockery/releases/download/v${MOCKERY_BINARY_VER}/mockery_${MOCKERY_BINARY_VER}_Linux_x86_64.tar.gz \
    && tar -xvf mockery_${MOCKERY_BINARY_VER}_Linux_x86_64.tar.gz \
    && rm -f mockery_${MOCKERY_BINARY_VER}_Linux_x86_64.tar.gz \
    && mv mockery /usr/local/bin/ \
    && chmod +x /usr/local/bin/mockery

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
