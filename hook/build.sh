#!/bin/bash
docker build --no-cache \
       --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
       -t oupfiz5/openacs-s6:5.9.1 \
       -t oupfiz5/openacs-s6:latest \
       -f ../Dockerfile \
        ../.
