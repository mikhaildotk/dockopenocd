# Builder stage
FROM debian AS builder
LABEL maintainer="kapranov.m@gmail.com"
ENV BUILDFUTURE="--enable-ftdi --enable-ft232r --enable-dummy"
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
RUN git clone git://git.code.sf.net/p/openocd/code .
RUN ./bootstrap && ./configure \
        --prefix=/opt/openocd \
	$BUILDFUTURE
RUN make && make install
CMD /bin/bash

# Application stage
FROM debian AS app
LABEL maintainer="kapranov.m@gmail.com"
RUN apt update  &&  apt install -y \
        libusb-1.0-0 \
        && rm -rf /var/lib/apt/lists/*
COPY --from=builder /opt/ /opt/
ENV PATH="${PATH}:/opt/openocd/bin"
EXPOSE 4444/tcp
EXPOSE 6666/tcp
CMD [ "openocd", "-f", "interface/dummy.cfg", "-c", "bindto 0.0.0.0" ]
