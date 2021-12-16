FROM golang:1.17-bullseye

RUN apt install apt-transport-https ca-certificates -y

RUN apt update
RUN apt install gcc tzdata upx -y
RUN apt install build-essential pkg-config libglib2.0-dev libexpat1-dev libgsf-1-dev libvips-dev -y

RUN wget https://github.com/libvips/libvips/releases/download/v8.12.1/vips-8.12.1.tar.gz \
    && tar xf vips-8.12.1.tar.gz && ./vips-8.12.1/configure \
    && make && make install && ldconfig

RUN rm -rf ./*

