#!/bin/sh

OOCD_LASTAG=`git ls-remote --refs --tags git://git.code.sf.net/p/openocd/code | cut --delimiter='/' --fields=3 |  tr '-' '~' | sort --version-sort | tail --lines=1`
docker rmi $(docker images -qa -f 'label=boocd')
#docker rmi $(docker images -qa -f 'dangling=true')

docker build --no-cache --target builder --progress=plain --tag foobar/openocd:${OOCD_LASTAG} --label boocd .
#docker build --no-cache --target app --progress=plain --tag foobar/openocd:0.12 --label boocd .

docker run --rm -it -v /dev:/dev -p 4444:4444 -p 6666:6666 foobar/openocd:${OOCD_LASTAG}
