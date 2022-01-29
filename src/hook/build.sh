#!/bin/bash
# shellcheck disable=SC1091
set -a; source ../VERSION ; set +a;

IMAGE="${IMAGE:-oupfiz5/openacs-s6:${VERSION}}"

docker build \
       --no-cache \
       --build-arg BUILD_DATE="$(date -u +"%Y-%m-%dT%H:%M:%SZ")" \
       --build-arg OACS_TAG="oacs-5-10"\
       -t "${IMAGE}" \
       -f ../Dockerfile \
       ../.
