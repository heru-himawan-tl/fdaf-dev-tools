#!/bin/bash

APP_CODE_NAME=fdaf

while true; do
    clear
    date
    cp -afv development-source/io.sourceforge.fdaf/fdaf/custom-core-source/webapp/src/main/resources/META-INF/resources/css/custom-style.css \
    deployment-test/$APP_CODE_NAME-with-hibernate/webapp/WEB-INF/classes/META-INF/resources/css/custom-style.css
    cp -afv development-source/io.sourceforge.fdaf/fdaf/core-source/webapp/src/main/resources/META-INF/resources/css/style.css \
    deployment-test/$APP_CODE_NAME-with-hibernate/webapp/WEB-INF/classes/META-INF/resources/css/style.css
    cp -afv development-source/io.sourceforge.fdaf/fdaf/core-source/webapp/src/main/webapp/WEB-INF/templates \
    deployment-test/$APP_CODE_NAME-with-hibernate/webapp/WEB-INF
    cp -afv development-source/io.sourceforge.fdaf/fdaf/core-source/webapp/src/main/webapp/*xhtml \
    deployment-test/$APP_CODE_NAME-with-hibernate/webapp/.
    cp -afv development-source/io.sourceforge.fdaf/fdaf/custom-core-source/webapp/src/main/webapp \
    deployment-test/$APP_CODE_NAME-with-hibernate
    sleep 2
done
