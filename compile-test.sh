#!/bin/bash

reset

CWD=$(pwd)
BASE=$(basename $CWD)
cd development-source/io.sourceforge.fdaf/fdaf

if mvn clean compile -P initialize-compilable; then
    cd $CWD
    cd compilable-source/"$BASE-$1"
    if mvn; then
        if [ "$1" != "thorntail" ]; then
            cd $CWD
            cd deployment
            mvn -Dcode_name="$BASE" -Dvariant="$1"
            cd $CWD
        else
            if [ -f "build/$BASE-$1.jar" ]; then
                cp -afv build/$BASE-$1.jar ../../$BASE-$1.jar
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
