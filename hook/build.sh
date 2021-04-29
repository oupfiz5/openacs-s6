#!/bin/bash
set -a; source ../VERSION ; set +a;

if [[ ${BRANCH} == 'dev' ]]; then
    TAG_PREFIX='dev-'
else
    TAG_PREFIX=""
fi

docker build --no-cache \
       --build-arg BUILD_DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ") \
       --build-arg OACS_TAG="${VERSION}"\
       -t oupfiz5/openacs-s6:"${TAG_PREFIX}${VERSION:-undefine}" \
       -t oupfiz5/openacs-s6:"${TAG_PREFIX}latest" \
       -f ../Dockerfile \
        ../.
