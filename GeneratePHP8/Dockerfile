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
    php84 php84-fpm php84-opcache php84-pecl-xdebug\
    php84-zlib php84-curl php84-session php84-json\
    php84-gd php84-exif php84-zip php84-mysqli supervisor\
    php84-pdo php84-iconv php84-fileinfo php84-xml\
    php84-common php84-intl php84-bcmath php84-dom\
    php84-pdo_mysql php84-xmlwriter php84-phar php84-ctype\
    php84-soap php84-sockets php84-tidy php84-pecl-imagick\
    php84-pgsql php84-sodium php84-tokenizer php84-xmlreader\
    php84-pdo_pgsql php84-simplexml php84-mbstring\
    php84-pear php84-dev gcc musl-dev make ghostscript-fonts ghostscript\
    && ln -sf /usr/bin/php84 /usr/bin/php\
    && rm -rf /var/lib/apt/lists/* && rm -rf /var/cache/apt/*\
    && rm -rf /tmp/{.}* /tmp/*\
    && rm -rf /var/cache/apk/*

# Installing composer
RUN curl -sS https://getcomposer.org/installer -o composer-setup.php\
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer\
    && rm -rf composer-setup.php

# Copy EntryPoint Configuration
COPY php.ini /etc/php84/php.ini
COPY www.conf /etc/php84/php-fpm.d/www.conf
COPY 50_xdebug.ini /etc/php84/conf.d/50_xdebug.ini
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

