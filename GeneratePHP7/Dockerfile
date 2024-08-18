FROM alpine:3.15

LABEL org.opencontainers.image.maintainer="Luis Felipe Sanchez <lfelipe1501@gmail.com>"\
      org.opencontainers.image.authors="lfsystems Community"\
      org.opencontainers.image.description="PHP 7.4 Alpine BASE for LEMP Stack"\
      org.opencontainers.image.documentation="https://github.com/lfelipe1501/LEMPDocker"\
      org.opencontainers.image.title="PHP 7.4 LEMP"\
      org.opencontainers.image.vendor="lfsystems Community"\
      org.opencontainers.image.version="7.4"

# Set Variables
ARG VPHP
ENV TZ=Etc/UTC\
    VPHP=7

# Create user to protect container
RUN addgroup -g 1000 phpusr\
    && adduser phpusr --shell /sbin/nologin\
    --disabled-password --uid 1000 --ingroup phpusr

# Install php and prepare
RUN apk update && apk upgrade --available && sync\
    && apk add --no-cache nano bash vim curl wget sqlite\
    tzdata zip unzip openssl busybox-extras linux-headers\
    php7 php7-fpm php7-opcache php7-pecl-xdebug\
    php7-zlib php7-curl php7-session php7-json\
    php7-gd php7-exif php7-zip php7-mysqli supervisor\
    php7-pdo php7-iconv php7-fileinfo php7-xml php7-mcrypt\
    php7-common php7-intl php7-bcmath php7-dom php7-mbstring\
    php7-pdo_mysql php7-xmlwriter php7-phar php7-ctype\
    php7-soap php7-sockets php7-tidy php7-pecl-imagick\
    php7-pear php7-dev gcc musl-dev make ghostscript-fonts ghostscript\
    && ln -sf /usr/bin/php7 /usr/bin/php\
    && rm -rf /var/lib/apt/lists/* && rm -rf /var/cache/apt/*\
    && rm -rf /tmp/{.}* /tmp/*\
    && rm -rf /var/cache/apk/*
# Installing composer
RUN curl -sS https://getcomposer.org/installer -o composer-setup.php\
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer\
    && rm -rf composer-setup.php

# Copy EntryPoint Configuration
COPY php.ini /etc/php7/php.ini
COPY www.conf /etc/php7/php-fpm.d/www.conf
COPY 50_xdebug.ini /etc/php7/conf.d/50_xdebug.ini
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
