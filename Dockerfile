FROM debian
LABEL maintainer="kapranov.m@gmail.com"
RUN apt update     && \
    apt upgrade -y && \
    apt install \
      git \
      make \
      libtool \
      pkg-config \
      autoconf \
      automake \
      texinfo \
      -y
RUN mkdir -p /usr/src/openocd
WORKDIR /usr/src/openocd
RUN git clone git://git.code.sf.net/p/openocd/code .
RUN ./bootstrap && ./configure --prefix=/opt/openocd 
RUN make && make install
