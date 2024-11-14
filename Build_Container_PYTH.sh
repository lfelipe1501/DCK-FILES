#!/bin/sh

#
# Script to Generate lfsys CONTAINER for LEMP Stack.
#
# @author   Luis Felipe <lfelipe1501@gmail.com>
# @website  https://www.lfsystems.com.co
# @version  1.0

echo ""
echo "Generando Contenedor de PYTHON 3"
echo ""
docker buildx build --push --platform linux/arm64,linux/amd64 -t lfsys/python:latest GeneratePYTHON/.
echo ""

echo ""
echo "Todo listo =)"
echo ""
