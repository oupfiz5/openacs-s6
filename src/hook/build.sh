#!/bin/bash
# shellcheck disable=SC1091
set -a; source ../VERSIONS ; set +a;

IMAGE="${IMAGE:-oupfiz5/openacs-s6:${OACS_IMG_TAG}}"

docker build \
       --no-cache \
       --build-arg BUILD_DATE="$(date -u +"%Y-%m-%dT%H:%M:%SZ")" \
       --build-arg NS_IMAGE_TAG="${NS_IMAGE_TAG}" \
       --build-arg OACS_TAG="${OACS_TAG}" \
       -t "${IMAGE}" \
       -f ../Dockerfile \
       ../.
