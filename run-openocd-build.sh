#!/bin/sh
docker rmi $(docker images -qa -f 'label=boocd')
#docker rmi $(docker images -qa -f 'dangling=true')
#docker build --no-cache --target builder --progress=plain --tag openoc-build --label boocd .
docker build --no-cache --target app --progress=plain --tag openocd --label boocd .

docker run --rm -it -v /dev:/dev -p 4444:4444 -p 6666:6666 openocd:latest
