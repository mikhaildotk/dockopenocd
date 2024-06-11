FROM debian
LABEL maintainer="kapranov.m@gmail.com"
RUN apt update  &&  apt install -y \
      bash \
      git \
      make \
      libtool \
      pkg-config \
      autoconf \
      automake \
      texinfo \
      && rm -rf /var/lib/apt/lists/*
RUN mkdir -p /usr/src/openocd
WORKDIR /usr/src/openocd
RUN git clone git://git.code.sf.net/p/openocd/code .
RUN ./bootstrap && ./configure --prefix=/opt/openocd 
RUN make && make install
