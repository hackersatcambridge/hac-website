FROM ibmcom/swift-ubuntu:4.0.3

# Allow installation of Node 6: https://nodejs.org/en/download/package-manager/#debian-and-ubuntu-based-linux-distributions \
# Install Yarn: https://yarnpkg.com/en/docs/install#linux-tab

RUN \
  export DEBIAN_FRONTEND=noninteractive && \
  apt-get update && \
  apt-get install -y \
    curl \
    apt-transport-https && \
  curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash - && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && \
  apt-get install -y \
    nodejs \
    yarn && \
  npm install -g n && \
  n 6.11.3
  
# Install PostgreSQL library
RUN apt-get install -y libpq-dev

RUN yarn config set cache-folder /yarn_cache

WORKDIR /root/hac-website/
