#!/bin/bash
set -e

stunnelimage="${IMAGE_NAME_ROOT}stunnel"
stunneltag="${STUNNEL_VERSION}-alpine-${ALPINE_VERSION}"

if [ -z "$FORCE" ] && docker manifest inspect "${stunnelimage}:${stunneltag}" > /dev/null 2>&1; then
    echo "Skipping ${stunnelimage}:${stunneltag}, already exists."
else
  docker build . \
    --build-arg BUILD_IMAGE="alpine:${ALPINE_VERSION}" \
    --build-arg STUNNEL_VERSION=$STUNNEL_VERSION \
    --tag "${stunnelimage}:${stunneltag}"

  docker push "${stunnelimage}:${stunneltag}"
fi
