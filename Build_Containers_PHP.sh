#!/bin/sh

#
# Script to Generate lfsys CONTAINERs for LEMP Stack.
#
# @author   Luis Felipe <lfelipe1501@gmail.com>
# @website  https://www.lfsystems.com.co
# @version  1.0

echo ""
echo "Generando Contenedor de PHP 7.4"
echo ""
#docker build --builder cloud-lfsys-lfsystems --push --platform linux/arm64,linux/amd64 -t lfsys/php74:latest GeneratePHP7/.
docker buildx build --push --platform linux/arm64,linux/amd64 --output type=image,compression=zstd -t lfsys/php74:latest GeneratePHP7/.
echo ""

echo ""
echo "Generando Contenedor de PHP 8"
echo ""
#docker build --builder cloud-lfsys-lfsystems --push --platform linux/arm64,linux/amd64 -t lfsys/php:latest GeneratePHP8/.
docker buildx build --push --platform linux/arm64,linux/amd64 --output type=image,compression=zstd -t lfsys/php:latest GeneratePHP8/.
echo ""

echo ""
echo "Todo listo =)"
echo ""
