#!/bin/bash
docker build --no-cache \
       --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
       -t oupfiz5/openacs-s6:oacs-5-10 \
       -t oupfiz5/openacs-s6:latest \
       -f ../Dockerfile \
        ../.
