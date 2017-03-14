FROM ibmcom/swift-ubuntu:3.0.2

RUN \
  export DEBIAN_FRONTEND=noninteractive && \
  apt-get update && \
  apt-get install curl apt-transport-https && \
  # Allow installation of Node 6: https://nodejs.org/en/download/package-manager/#debian-and-ubuntu-based-linux-distributions \
  curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash - && \
  apt-get update && \
  apt-get install nodejs && \
  # Install Yarn: https://yarnpkg.com/en/docs/install#linux-tab
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && sudo apt-get install yarn

RUN yarn config set cache-folder /yarn_cache

WORKDIR /root/hac-website/
