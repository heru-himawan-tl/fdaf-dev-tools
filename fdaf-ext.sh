#!/bin/bash

reset

CWD=$(pwd)

BASE="../development-source/io.sourceforge.fdaf/fdaf"

if [ ! -d "fdaf-framework" ]; then
    mkdir fdaf-framework
fi

mkdir -p fdaf-framework/dist/tool
mkdir -p fdaf-framework/dist/release

cd fdaf-framework
for fdir in $(echo "application-primitive-entity-model custom-base custom-core-source"); do
    if [ ! -d "$fdir" ]; then
        mkdir $fdir
    fi
done

cd application-primitive-entity-model

cp -afv ../$BASE/application-primitive-entity-model/README.md .
cp -afv ../$BASE/application-primitive-entity-model/pom.xml .
mkdir -p src/main/java/fdaf/logic/entity

echo "See: /application-primitive-entity-model/README.md" > src/main/java/fdaf/logic/entity/README.md

cd ../

cd custom-base

cp -afv ../$BASE/custom-base/README.md .
cp -afv ../$BASE/custom-base/pom.xml .
mkdir -p src/main/java/fdaf/base

echo "This directory for placing your custom base library sources instead of /base/ ." > src/main/java/fdaf/base/README.md

cd ../

cd custom-core-source

cp -afv ../$BASE/custom-core-source/README.md .

mkdir -p base/src/main/java/fdaf/base
mkdir -p logic/src/main/java/fdaf/logic/base
mkdir -p logic/src/main/java/fdaf/logic/ejb/callback
mkdir -p logic/src/main/java/fdaf/logic/ejb/facade
mkdir -p logic/src/main/java/fdaf/logic/ejb/repository
mkdir -p logic/src/main/java/fdaf/logic/ejb/services
mkdir -p webapp/src/main/java/fdaf/webapp/base
mkdir -p webapp/src/main/java/fdaf/webapp/bean/common
mkdir -p webapp/src/main/java/fdaf/webapp/bean/system
mkdir -p webapp/src/main/java/fdaf/webapp/bean/utility
mkdir -p webapp/src/main/java/fdaf/webapp/servlet
mkdir -p webapp/src/main/java/fdaf/webapp/websocket
mkdir -p webapp/src/main/resources/fdaf/webapp/rc/messages

echo "" > webapp/src/main/resources/fdaf/webapp/rc/messages/custom_callback_message.properties
echo "" > webapp/src/main/resources/fdaf/webapp/rc/messages/custom_label.properties
echo "" > webapp/src/main/resources/fdaf/webapp/rc/messages/custom_message.properties

echo "See: /core-source/README.md" >  base/src/main/java/fdaf/base/README.md
echo "See: /core-source/README.md" >  logic/src/main/java/fdaf/logic/base/README.md
echo "See: /core-source/README.md" >  logic/src/main/java/fdaf/logic/ejb/callback/README.md
echo "See: /core-source/README.md" >  logic/src/main/java/fdaf/logic/ejb/facade/README.md
echo "See: /core-source/README.md" >  logic/src/main/java/fdaf/logic/ejb/repository/README.md
echo "See: /core-source/README.md" >  logic/src/main/java/fdaf/logic/ejb/services/README.md
echo "See: /core-source/README.md" >  webapp/src/main/java/fdaf/webapp/base/README.md
echo "See: /core-source/README.md" >  webapp/src/main/java/fdaf/webapp/bean/common/README.md
echo "See: /core-source/README.md" >  webapp/src/main/java/fdaf/webapp/bean/system/README.md
echo "See: /core-source/README.md" >  webapp/src/main/java/fdaf/webapp/bean/utility/README.md
echo "See: /core-source/README.md" >  webapp/src/main/java/fdaf/webapp/servlet/README.md
echo "See: /core-source/README.md" >  webapp/src/main/java/fdaf/webapp/websocket/README.md
echo "See: /core-source/README.md" >  webapp/src/main/resources/fdaf/webapp/rc/messages/README.md

cd ../

for sf in $(echo "base
    cleaner
    compilable-init
    compilable-init-clear
    compilable-init-preparation
    core-primitive-entity-model
    core-source
    modeler
    templates
    thorntail-build-invoker
    with-eclipselink-build-invoker
    with-hibernate-build-invoker
    printing-service-client
    pom.xml"); do
    if [ ! -e "$sf" ]; then
        ln -s $BASE/$sf ./$sf
    fi
done

CONF=$(
cat <<ADDTEXT
#
# CAUTIONS:
#
# 1.    Set fdaf.applicationSourceDirectory properly & carefully,
#       since particular contents or sub-directories under it will be
#       deleted upon the "clean" phase being executed.
#
# 2.    Set fdaf.thorntailVersion carefully. Thorntail varsion
#       2.4.0.Final or earlier compatible only with MySQL Connector/J V.5x.
#

# General properties
fdaf.applicationCodeName=fdaf
fdaf.applicationDescription=FDAF - Flexible Database Access Application Framework
fdaf.applicationGroupId=io.sourceforge.fdaf
fdaf.applicationName=FDAF
fdaf.applicationSourceDirectory=../../../compilable-source
fdaf.applicationVersion=1.0
fdaf.copyright=Copyright (C) Heru Himawan Tejo Laksono
fdaf.developerHomePage=https://github.com/heru-himawan-tl/fdaf

# Common datasource properties
fdaf.dataSourceName=MySqlFDAF

# JPA properties
fdaf.jpaUnitName=fdaf.jpa.unit

# Thorntail compilation properties
fdaf.thorntailVersion=2.7.0.Final
fdaf.thorntailDataSourceConnectionURL=jdbc:mysql://localhost:3306/fdaf?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC
fdaf.thorntailDataSourcePassword=your-defined-password-here
fdaf.thorntailDataSourceUserName=root
fdaf.thorntailDbConnectorDependencyArtifactId=mysql-connector-java
fdaf.thorntailDbConnectorDependencyGroupId=mysql
fdaf.thorntailDbConnectorDependencyVersion=8.0.16
fdaf.thorntailDataSourceDriverName=mysql
ADDTEXT
)

echo -e "$CONF" > develop.properties

COPY_TARGET=

for drf in $(ls); do
    if [ "$drf" != "dist" ]; then
        if [ -d "$drf" ]; then
            COPY_TARGET="$COPY_TARGET<copy todir=\"../release/$drf\"><fileset dir=\"../../$drf\" /></copy>\n"
        else
            COPY_TARGET="$COPY_TARGET<copy file=\"../../$drf\" tofile=\"../release/$drf\"/>\n"
        fi
    fi
done

TOOL_POM=$(
cat <<ADDTEXT
<?xml version="1.0" encoding="UTF-8"?>
<!--

Copyright (c) Heru Himawan Tejo Laksono. All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice,
   this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.

3. Neither the name of the copyright holders nor the names of its
   contributors may be used to endorse or promote products derived from this
   software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED. IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

-->
<project xmlns="http://maven.apache.org/POM/4.0.0"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    
    <modelVersion>4.0.0</modelVersion>
    
    <groupId>io.sourceforge.fdaf_dt</groupId>
    <artifactId>fdaf_dt</artifactId>
    <version>1.0</version>
    <packaging>pom</packaging>
    <name>The F.D.A.F Distribution Tool</name>
    
    <properties>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <project.reporting.outputEncoding>UTF-8</project.reporting.outputEncoding>
    </properties>
    
    <build>
        <directory>\${java.io.tmpdir}\${file.separator}\${project.groupId}\${file.separator}\${file.separator}\${project.artifactId}</directory>
        <defaultGoal>compile</defaultGoal> 
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-install-plugin</artifactId>
                <version>2.5.2</version>
                <configuration>
                    <skip>true</skip>
                </configuration>
            </plugin>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-antrun-plugin</artifactId>
                <version>1.8</version>
                <configuration>
                    <target>
                        $COPY_TARGET
                    </target>
                </configuration>
                <executions>
                    <execution>
                        <id>compile</id>
                        <phase>compile</phase>
                        <goals>
                            <goal>run</goal>
                        </goals>
                    </execution>
                </executions>
            </plugin>
        </plugins>
    </build>
    
</project>
ADDTEXT
)

echo -e "$TOOL_POM" > dist/tool/pom.xml

cd dist/release

for node in $(echo "application-primitive-entity-model
base
cleaner
compilable-init
compilable-init-clear
compilable-init-preparation
core-primitive-entity-model
core-source
custom-base
custom-core-source
modeler
templates
thorntail-build-invoker
with-eclipselink-build-invoker
with-hibernate-build-invoker
develop.properties
printing-service-client
pom.xml
README.md"); do
    rm -rf $node
done

cd ../../

cat ../FDAF-README.md > dist/release/README.md

cd dist/tool

mvn

cd ../../

cd dist/release

rm -rf printing-service-client/target

echo "" > templates/logic-resource-template/src/main/resources/META-INF/sql/application-table-create.sql

if [ "$1" = "--to-git" ]; then
    git add .
    git commit -m "Routine Code Update `date`"
    git push -u origin master
fi

cd $CWD
