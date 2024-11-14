FROM python:3.13-slim

LABEL org.opencontainers.image.maintainer="Luis Felipe Sanchez <lfelipe1501@gmail.com>"\
      org.opencontainers.image.authors="lfsystems Community"\
      org.opencontainers.image.description="PYTHON 3 with Official BASE for LEPP Stack"\
      org.opencontainers.image.documentation="https://github.com/lfelipe1501/LEPPDocker"\
      org.opencontainers.image.title="PYTHON 3"\
      org.opencontainers.image.vendor="lfsystems Community"\
      org.opencontainers.image.version="1.0"

# Set Variables
ENV CHARSET=UTF-8\
    TZ=Etc/UTC

# Create user to protect container
RUN groupadd -g 1000 pyusr\
    && useradd pyusr --shell /usr/sbin/nologin\
    -u 1000 -g pyusr

# Init Python Configuration
RUN mkdir /app && chmod 777 /app
COPY entrypoint.sh /entrypoint.sh

# Install dependencies
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install --no-install-recommends -y openssl\
    bash-completion zip unzip nano gnupg2 debian-archive-keyring\
    curl wget net-tools lsb-release ca-certificates gcc libc6-dev libpq5\
    && apt-get autoremove --purge -y && apt-get autoclean -y && apt-get clean -y\
    && rm -rf /var/lib/apt/lists/*\
    && rm -rf /tmp/* /var/tmp/*\
    && chown -R 1000:1000 /app\
    && chown -R 1000:1000 /var/run\
    && chmod -R 777 /var/run\
    && chown -R 1000:1000 /var/cache\
    && chown 1000:1000 /etc/localtime\
    && chown 1000:1000 /etc/timezone\
    && chmod 777 /entrypoint.sh\
    && chown 1000:1000 /entrypoint.sh

USER pyusr
WORKDIR /app

# 8000 8001 (web access)
EXPOSE 8000 8001

# Run the application
CMD ["/entrypoint.sh"]

