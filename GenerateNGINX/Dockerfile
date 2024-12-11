FROM alpine:latest

LABEL org.opencontainers.image.maintainer="Luis Felipe Sanchez <lfelipe1501@gmail.com>"\
      org.opencontainers.image.authors="lfsystems Community"\
      org.opencontainers.image.description="NGINX with UI Alpine BASE for LEMP Stack"\
      org.opencontainers.image.documentation="https://github.com/lfelipe1501/LEMPDocker"\
      org.opencontainers.image.title="NGINX with UI"\
      org.opencontainers.image.vendor="lfsystems Community"\
      org.opencontainers.image.version="1.0"

# Set Variables
ARG TARGETPLATFORM
ENV TZ=Etc/UTC

# Create user to protect container
RUN addgroup -g 1000 nginx\
    && adduser nginx --shell /sbin/nologin\
    --disabled-password --uid 1000 --ingroup nginx

# Install php and prepare
RUN apk update && apk upgrade --available && sync\
    && apk add --no-cache nano bash wget nginx openrc\
    tzdata zip unzip openssl nginx-mod-http-xslt-filter \
    vim curl nginx-mod-http-fancyindex \
    && [ $TARGETPLATFORM == "linux/amd64" ] && { ARCH_TYPE="linux-64"; } || { ARCH_TYPE="linux-arm64-v8a"; }\
    && NGINXUI_VERSION=$(curl -s https://api.github.com/repos/0xJacky/nginx-ui/releases/latest|grep tag_name | cut -d '"' -f 4|sed 's/v//g' | sed s/"release-"//)\
    && wget https://github.com/0xJacky/nginx-ui/releases/download/v${NGINXUI_VERSION}/nginx-ui-${ARCH_TYPE}.tar.gz\
    && tar -xvzf nginx-ui-${ARCH_TYPE}.tar.gz && rm -rf *.md && chmod 777 nginx-ui\
    && mv nginx-ui /bin && rm -rf nginx-ui-${ARCH_TYPE}.tar.gz && mkdir -p /etc/nginx-ui && ln -sf /etc/nginx-ui /app \
    && mkdir -p /var/www/html/logs \
    && rm -rf /var/lib/apt/lists/* && rm -rf /var/cache/apt/*\
    && rm -rf /tmp/{.}* /tmp/*\
    && rm -rf /var/cache/apk/*

COPY nginx.zip /etc/nginx.zip
COPY default.zip /default.zip

# Copy EntryPoint Configuration
COPY start.sh /start.sh
COPY app.ini /etc/nginx-ui/app.ini

# Clear package lists
RUN rm -rf /etc/nginx && unzip -o /etc/nginx.zip -d /etc/ \
    && unzip -o /etc/nginx.zip -d /usr/etc/ \
    && mkdir -p /usr/etc/nginx-ui \
    && cp /etc/nginx-ui/app.ini /usr/etc/nginx-ui/ \
    && cat /usr/share/zoneinfo/${TZ} > /etc/localtime \
    && echo $TZ > /etc/timezone \
    && chown -R 1000:1000 /etc/nginx \
    && chown -R 1000:1000 /usr/etc/nginx* \
    && chown -R 1000:1000 /etc/nginx-ui \
    && chown -R 1000:1000 /var/run \
    && chmod -R 777 /var/run \
    && chmod -R 777 /run \
    && chown -R 1000:1000 /run \
    && chown -R 1000:1000 /var/cache \
    && chown -R 1000:1000 /var/log/nginx \
    && rm -rf /var/log/nginx \
    && ln -sf /var/www/html/logs /var/log/nginx \
    && chown -h 1000:1000 /var/log/nginx \
    && chown 1000:1000 /etc/localtime \
    && chown 1000:1000 /etc/timezone \
    && unzip -o /default.zip -d /var/www/html/ \
    && rm -rf /default.zip \
    && chown -R 1000:1000 /var/www \
    && chmod 777 /start.sh \
    && chown 1000:1000 /bin/nginx-ui \
    && chown 1000:1000 /start.sh

EXPOSE 80 81 443

USER nginx
WORKDIR /app

# Run the application
CMD ["/start.sh"]
