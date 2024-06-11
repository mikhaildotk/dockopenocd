#!/bin/sh
docker build --no-cache --progress=plain --tag openoc-build --label boocd .
docker run --rm -it openoc-build:latest bash

#docker build --tag my-image:latest --label my-label ubuntu:latest
#docker image prune --force --filter='label=my-label'
# OR
#docker rmi $(docker images -qa -f 'dangling=true')
