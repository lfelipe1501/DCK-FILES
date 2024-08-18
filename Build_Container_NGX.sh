#!/bin/sh

#
# Script to Generate lfsys CONTAINER for LEMP Stack.
#
# @author   Luis Felipe <lfelipe1501@gmail.com>
# @website  https://www.lfsystems.com.co
# @version  1.0

echo "Generando Contenedor de NGINX + UI"
echo ""
docker buildx build --push --platform linux/arm64,linux/amd64 -t lfsys/nginx:latest GenerateNGINX/.
echo ""

echo ""
echo "Todo listo =)"
echo ""
