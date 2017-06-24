FROM ubuntu:xenial

ARG NODE_VERSION=7.6.0
ARG NPM_VERSION=5.0.0

ENV NODE_VERSION ${NODE_VERSION}
ENV NPM_VERSION ${NPM_VERSION}

WORKDIR /headless

# Install google chrome
RUN apt-get update \
    && apt-get install -y wget \
    && wget -q -O - --no-check-certificate https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list' \
    && apt-get update \
    && apt-get install -y google-chrome-stable

# Install node and npm
RUN wget "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz" \
    && tar -xzf "node-v$NODE_VERSION-linux-x64.tar.gz" -C /usr/local --strip-components=1 \
    && rm "node-v$NODE_VERSION-linux-x64.tar.gz" \
    && npm install -g npm@"$NPM_VERSION" \
    && npm install chrome-headless-screenshots-fork


# wget https://raw.githubusercontent.com/jfrazelle/dotfiles/master/etc/docker/seccomp/chrome.json -O ~/chrome.json
# NOTE: must docker run with --security-opt seccomp=$HOME/chrome.json
