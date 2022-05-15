# Use a clean tiny image to store artifacts in
FROM ubuntu:jammy-20220428

# Copy all needed files
COPY entrypoint.sh /

# Install needed packages
SHELL ["/bin/bash", "-euxo", "pipefail", "-c"]
# hadolint ignore=DL3008
RUN chmod +x /entrypoint.sh ;\
  apt-get update -y ;\
  apt-get install --no-install-recommends -y \
    gpg-agent \
    software-properties-common ;\
  add-apt-repository ppa:git-core/ppa ;\
  apt-get update -y ;\
  apt-get install --no-install-recommends -y \
    git \
    hub \
    jq ;\
  apt-get clean ;\
  rm -rf /var/lib/apt/lists/*

# Finish up
CMD ["hub version"]
WORKDIR /github/workspace
ENTRYPOINT ["/entrypoint.sh"]
