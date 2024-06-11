#!/bin/sh
docker rmi $(docker images -qa -f 'label=boocd')
#docker rmi $(docker images -qa -f 'dangling=true')
docker build --no-cache --progress=plain --tag openoc-build --label boocd .
docker run --rm -it openoc-build:latest bash
