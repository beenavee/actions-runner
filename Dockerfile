FROM --platform=$BUILDPLATFORM docker.io/myoung34/github-runner:ubuntu-noble

ENV MOCKERY_BINARY_VER=2.43.2

RUN apt-get update && apt-get install -y ansible-core \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean \
    && apt-get autoremove -y

RUN cd /tmp \
    && wget https://github.com/vektra/mockery/releases/download/v${MOCKERY_BINARY_VER}/mockery_${MOCKERY_BINARY_VER}_Linux_x86_64.tar.gz \
    && tar -xvf mockery_${MOCKERY_BINARY_VER}_Linux_x86_64.tar.gz \
    && rm -f mockery_${MOCKERY_BINARY_VER}_Linux_x86_64.tar.gz \
    && mv mockery /usr/local/bin/ \
    && chmod +x /usr/local/bin/mockery
