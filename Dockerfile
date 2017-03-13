FROM ibmcom/swift-ubuntu:3.0.2

RUN \
  export DEBIAN_FRONTEND=noninteractive && \
  apt-get update && \
  apt-get install curl && \
  # Allow installation of Node 6: https://nodejs.org/en/download/package-manager/#debian-and-ubuntu-based-linux-distributions \
  curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash - && \
  apt-get update && \
  apt-get install nodejs && \
  # Yarn's installation instructions did not work, so we are falling back to npm to install it
  npm install -g yarn;

RUN yarn config set cache-folder /yarn_cache

WORKDIR /root/hac-website/
