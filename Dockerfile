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
        libusb-1.0-0-dev \
        && rm -rf /var/lib/apt/lists/*
RUN mkdir -p /usr/src/openocd
WORKDIR /usr/src/openocd

#RUN git clone git://git.code.sf.net/p/openocd/code .
#RUN ./bootstrap && ./configure \
#        --prefix=/opt/openocd \
#        --enable-ftdi \
#        --enable-ft232r \
#	--enable-dummy
#RUN make && make install

RUN echo "alias run='git clone git://git.code.sf.net/p/openocd/code . \
        && ./bootstrap \
        && ./configure \
        --prefix=/opt/openocd \
        --enable-ftdi \
        --enable-ft232r \
        --enable-dummy \
        && make \
        && make install'" >> $HOME/.bashrc
