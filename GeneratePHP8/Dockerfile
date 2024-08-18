FROM alpine:latest

LABEL org.opencontainers.image.maintainer="Luis Felipe Sanchez <lfelipe1501@gmail.com>"\
      org.opencontainers.image.authors="lfsystems Community"\
      org.opencontainers.image.description="PHP 8.3 Alpine BASE for LEMP Stack"\
      org.opencontainers.image.documentation="https://github.com/lfelipe1501/LEMPDocker"\
      org.opencontainers.image.title="PHP 8.3 LEMP"\
      org.opencontainers.image.vendor="lfsystems Community"\
      org.opencontainers.image.version="8.3"

# Set Variables
ARG VPHP
ENV TZ=Etc/UTC\
    VPHP=83

# Create user to protect container
RUN addgroup -g 1000 phpusr\
    && adduser phpusr --shell /sbin/nologin\
    --disabled-password --uid 1000 --ingroup phpusr

# Install php and prepare
RUN apk update && apk upgrade --available && sync\
    && apk add --no-cache nano bash vim curl wget sqlite\
    tzdata zip unzip openssl busybox-extras linux-headers\
    php83 php83-fpm php83-opcache php83-pecl-xdebug\
    php83-zlib php83-curl php83-session php83-json\
    php83-gd php83-exif php83-zip php83-mysqli supervisor\
    php83-pdo php83-iconv php83-fileinfo php83-xml\
    php83-common php83-intl php83-bcmath php83-dom\
    php83-pdo_mysql php83-xmlwriter php83-phar php83-ctype\
    php83-soap php83-sockets php83-tidy php83-pecl-imagick\
    php83-pgsql php83-sodium php83-tokenizer php83-xmlreader\
    php83-pdo_pgsql php83-simplexml php83-mbstring\
    php83-pear php83-dev gcc musl-dev make ghostscript-fonts ghostscript\
    && ln -sf /usr/bin/php83 /usr/bin/php\
    && rm -rf /var/lib/apt/lists/* && rm -rf /var/cache/apt/*\
    && rm -rf /tmp/{.}* /tmp/*\
    && rm -rf /var/cache/apk/*

# Installing composer
RUN curl -sS https://getcomposer.org/installer -o composer-setup.php\
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer\
    && rm -rf composer-setup.php

# Copy EntryPoint Configuration
COPY php.ini /etc/php83/php.ini
COPY www.conf /etc/php83/php-fpm.d/www.conf
COPY 50_xdebug.ini /etc/php83/conf.d/50_xdebug.ini
COPY start.sh /start.sh

# Clear package lists
RUN mkdir -p /var/www/html\
    && cat /usr/share/zoneinfo/${TZ} > /etc/localtime\
    && echo $TZ > /etc/timezone\
    && chown -R 1000:1000 /var/www\
    && chown -R 1000:1000 /var/log\
    && chown 1000:1000 /etc/localtime\
    && chown 1000:1000 /etc/timezone\
    && chown 1000:1000 /start.sh\
    && chmod 777 /start.sh

EXPOSE 9000

USER phpusr
WORKDIR /var/www/html/

# Run the application
CMD ["/start.sh"]

