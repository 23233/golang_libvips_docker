FROM golang:1.18.1-alpine as build

# 容器环境变量添加，会覆盖默认的变量值
ENV GO111MODULE=on
ENV GOPROXY=https://goproxy.cn,direct

# 新增upx 设置时区为上海
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk add tzdata upx \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone

RUN apk --update add build-base g++ make \
    	cmake \
    	autoconf \
    	automake \
    	libtool \
    	bc \
    	zlib-dev \
    	libxml2-dev \
    	jpeg-dev \
    	tiff-dev \
    	glib-dev \
    	gdk-pixbuf-dev \
    	sqlite-dev \
    	libjpeg-turbo-dev \
    	libexif-dev \
    	lcms2-dev \
    	fftw-dev \
    	giflib-dev \
    	libpng-dev \
    	libwebp-dev \
    	orc-dev \
    	poppler-dev \
    	librsvg-dev \
    	libgsf-dev \
    	openexr-dev \
    	gtk-doc

RUN wget https://gitee.com/23323/fj/attach_files/1032557/download/vips-8.12.2.tar.gz \
    && tar xf vips-8.12.2.tar.gz && cd vips-8.12.2 \
    && ./configure \
    && make V=0 && make install

# 禁止操作缓存 节约内存
RUN bimg.VipsCacheSetMax(0) && bimg.VipsCacheSetMaxMem(0)

