FROM ubuntu:xenial

ARG NODE_VERSION=7.6.0
ARG NPM_VERSION=5.0.0

ENV NODE_VERSION ${NODE_VERSION}
ENV NPM_VERSION ${NPM_VERSION}

WORKDIR /headless

# Install dependencies
RUN apt-get update \
    && apt-get install -y libxss1 fonts-liberation libappindicator1 libindicator7 curl \
    gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 \
    libfontconfig1 libfreetype6 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0  \
    libgtk2.0-0 libnspr4 libnspr4-0d libnss3 libnss3-1d libpango-1.0-0 libpangocairo-1.0-0 \
    libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 \
    libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 bash libnss3 xdg-utils \
    && curl -SLOk https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
    && dpkg -i google-chrome*.deb

# Install node and npm
RUN curl -SLOk "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz" \
    && tar -xzf "node-v$NODE_VERSION-linux-x64.tar.gz" -C /usr/local --strip-components=1 \
    && rm "node-v$NODE_VERSION-linux-x64.tar.gz" \
    && npm install -g npm@"$NPM_VERSION" \
    && npm install chrome-headless-screenshots-fork
