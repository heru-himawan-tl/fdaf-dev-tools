FDAF Development Tools
======================

This is a collection of FDAF development tools. It is designed to support
implementation of FDAF into testing-application or ready-to-deploy
application. It also designed to split current FDAF framework from current
development-source of application, to let the reuse of last modified FDAF
framework based current application project for creating another FDAF
application.

## Common Usage

### With Fresh FDAF Framework

To create application from a fresh FDAF framework, follow the following steps:

1. Clone the fresh FDAF framework from the GITHUB repository inside directory
of `development-source/io.sourceforge.fdaf`, so that development source
directory will become `development-source/io.sourceforge.fdaf/fdaf`.

2. Change the application properties in `development-source/io.sourceforge.fdaf/fdaf/develop.properties`
as necessary to meet your new application design preferences and specification.
More, do some stuff with your custom application codes.

3. Change the general application configuration in `application.conf` into
your FDAF application name, i.e "foo".

4. Call `./compile-test.sh` script from terminal console with one of the following
main options:
  - `with-hibernate` - to compile FDAF application with Hibernate JPA provider supports
  - `with-eclipselink` - to compile FDAF application with EclipseLink JPA provider supports
  - `thorntail` - to compile FDAF application into Thorntail application
  
### With Split or Modified FDAF Framework

To create application from a split FDAF framework, follow the following steps:

1. Call `./fdaf-ext.sh` script from terminal console without argument, from
inside your current FDAF application project. It will split current (or
modified) FDAF framework into the generated directory of `fdaf-framework/dist/release`.

2. Move all contents of `fdaf-framework/dist/release` into your new FDAF
application project that already contains a set of `fdaf-app-compile-tools`.
Place that split FDAF framework into directory of `development-source/io.sourceforge.fdaf/fdaf`
of your new FDAF application project.

3. Change the application properties in `development-source/io.sourceforge.fdaf/fdaf/develop.properties`
as necessary to meet your new application design preferences and specification.
More, do some stuff with your custom application codes.

4. Change the general application configuration in `application.conf` into
your FDAF application name, i.e "foo".

5. Call `./compile-test.sh` from terminal console with one of the following
main options:
  - `with-hibernate` - to compile FDAF application with Hibernate JPA provider supports
  - `with-eclipselink` - to compile FDAF application with EclipseLink JPA provider supports
  - `thorntail` - to compile FDAF application into Thorntail application

## Specific Usage

### Splitting FDAF Framework

To split FDAF framework from an application project, call `./fdaf-ext.sh`
script from terminal console without argument, from inside your current FDAF
application project. It will split current (or modified) FDAF framework into
the generated directory of `fdaf-framework/dist/release`.

Note:  
This will generate most of generated stuffs into default, i.e.
`develop.properties`.

### Realtime View Layers Element Update

In testing an FDAF web-application, you will need to compile FDAF into a
_testing-application_. This collection of tools will help you into such
purpose, by producing non-archived web-application and business-tier
application inside directory of `deployment/$APP_CODE_NAME-$PORT/`.

As of a _testing-application_ compiled, call `./update.sh` from a terminal
console under current project directory with one of options:

  - `with-hibernate` - to realtime update view layer for FDAF application with Hibernate JPA provider supports
  - `with-eclipselink` - to realtime update view layer for FDAF application with EclipseLink JPA provider supports
  
Note:  
This is not applicable for FDAF compiled as a Thorntail Application.

## License

Copyright (c) [Heru Himawan Tejo Laksono](https://github.com/heru-himawan-tl).
All rights reserved.

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




  
  