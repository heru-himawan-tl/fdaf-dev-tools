#!/bin/bash

APP_CODE_NAME=fdaf

. ./application.conf

PORT="$1"

while true; do
    clear
    date
    cp -afv development-source/io.sourceforge.fdaf/fdaf/custom-core-source/webapp/src/main/webapp/WEB-INF/resources/css/custom-style.css \
    deployment/$APP_CODE_NAME-$PORT/webapp/WEB-INF/resources/css/custom-style.css
    cp -afv development-source/io.sourceforge.fdaf/fdaf/core-source/webapp/src/main/webapp/WEB-INF/resources/css/style.css \
    deployment/$APP_CODE_NAME-$PORT/webapp/WEB-INF/resources/css/style.css
    cp -afv development-source/io.sourceforge.fdaf/fdaf/core-source/webapp/src/main/webapp/WEB-INF/templates \
    deployment/$APP_CODE_NAME-$PORT/webapp/WEB-INF
    cp -afv development-source/io.sourceforge.fdaf/fdaf/core-source/webapp/src/main/webapp/*xhtml \
    deployment/$APP_CODE_NAME-$PORT/webapp/.
    cp -afv development-source/io.sourceforge.fdaf/fdaf/custom-core-source/webapp/src/main/webapp \
    deployment/$APP_CODE_NAME-$PORT
    sleep 2
done
