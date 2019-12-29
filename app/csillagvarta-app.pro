
TARGET = csillagvarta-app
BUILD_ROOT=../..
COMPONENT_NAME=csillagvarta
include($${BUILD_ROOT}/build/qmake/application.pri)

SOURCES += \
    main.cc
    
lupdate_only {
SOURCES +=
}

HEADERS += \
    setup.h \
    defs.h

RESOURCES += \
    csillagvarta-app.qrc

LIBS += $$moduleDep(sdk,app)
LIBS += $$moduleDep(sdk,dox)
LIBS += $$moduleDep(astro,ephe)
LIBS += $$moduleDep(astro,calculo)

#DEPENDPATH += $$SYS_HOME/sdk/app
#DEPENDPATH += $$SYS_HOME/sdk/dox
#DEPENDPATH += $$SYS_HOME/astro/ephe
#DEPENDPATH += $$SYS_HOME/astro/calculo

QMAKE_EXTRA_TARGETS += $$object_dep_on_module_header(main)

include($${BUILD_ROOT}/build/qmake/qm-compile.pri)
