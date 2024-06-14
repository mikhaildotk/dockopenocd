# syntax=docker/dockerfile:1.2
# Builder stage
FROM debian AS builder
ENV BUILDFUTURE="--enable-ftdi --enable-ft232r --enable-dummy"
RUN \
        --mount=target=/var/lib/apt/lists,type=cache,sharing=locked \
        --mount=target=/var/cache/apt,type=cache,sharing=locked \
        rm -f /etc/apt/apt.conf.d/docker-clean ; echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' > /etc/apt/apt.conf.d/keep-cache \
        && apt update  &&  apt install -y \
        autoconf \
        automake \
        bash \
        git \
        make \
        libtool \
        pkg-config \
        texinfo \
        libusb-1.0-0-dev \
        && rm -rf /var/lib/apt/lists/*
RUN git clone git://git.code.sf.net/p/openocd/code /usr/src/openocd
WORKDIR /usr/src/openocd
RUN ./bootstrap && ./configure \
        --prefix=/opt/openocd \
	$BUILDFUTURE
RUN make && make install
CMD /bin/bash

# Application stage
FROM debian AS app
LABEL maintainer="kapranov.m@gmail.com" \
        website="https://blog.halfwave.ru" \
        description="Тестовая сборка OpenOCD"
RUN apt update  &&  apt install -y \
        libusb-1.0-0 \
        && rm -rf /var/lib/apt/lists/*
COPY --from=builder /opt/ /opt/
ENV PATH="${PATH}:/opt/openocd/bin"
EXPOSE 4444/tcp
EXPOSE 6666/tcp
CMD [ "openocd", "-f", "interface/dummy.cfg", "-c", "bindto 0.0.0.0" ]
