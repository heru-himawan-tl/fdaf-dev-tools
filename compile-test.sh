#!/bin/bash

reset

APP_CODE_NAME=
PORT=

. ./application.conf

CWD=$(pwd)
cd development-source/io.sourceforge.fdaf/fdaf

if mvn clean compile -P initialize-compilable; then
    cd $CWD
    cd compilable-source/"$APP_CODE_NAME-$PORT"
    if mvn; then
        if [ "$PORT" != "thorntail" ]; then
            cd $CWD
            cd deployment
            mvn -Dcode_name="$APP_CODE_NAME" -Dvariant="$PORT"
            cd $CWD
        else
            if [ -f "build/$APP_CODE_NAME-$PORT.jar" ]; then
                cp -afv build/$APP_CODE_NAME-$PORT.jar ../../$APP_CODE_NAME-$PORT.jar
            fi
        fi
    else
        cd $CWD
        exit
    fi
    cd $CWD
    if [ "$2" = "--git-push" ]; then
        cd development-source/io.sourceforge.fdaf/fdaf 
        git add .
        git commit -m "Routine Code Update `date`"
        git push -u origin master
        cd $CWD
    fi
fi

cd $CWD

date > last-update-ts
