#!/bin/bash
# shellcheck disable=SC1091
set -a; source ../VERSIONS ; set +a;

IMAGE="${IMAGE:-oupfiz5/openacs-s6:${OACS_IMG_TAG}}"

docker push "${IMAGE}"
