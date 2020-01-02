
TARGET = csillagvarta-app
BUILD_ROOT=../..
COMPONENT_NAME=csillagvarta
include($${BUILD_ROOT}/sdk/build/qmake/application.pri)

SOURCES += \
    main.cc \
    mainwindow.cc
    
lupdate_only {
SOURCES +=
}

HEADERS += \
    init.h \
    mainwindow.h \
    setup.h \
    defs.h

RESOURCES += \
    csillagvarta-app.qrc

LIBS += $$moduleDep(sdk,arch)
LIBS += $$moduleDep(sdk,network-qt)
LIBS += $$moduleDep(astro,sweph)
LIBS += $$moduleDep(qstro,eph)
LIBS += $$moduleDep(qstro,calculo)

QMAKE_EXTRA_TARGETS += $$object_dep_on_module_header(main)

#include($${BUILD_ROOT}/sdk/build/qmake/qm-compile.pri)

FORMS += \
    mainwindow.ui
