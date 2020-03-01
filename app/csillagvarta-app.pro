
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

LIBS += $$moduleDep(astro,uicontrols-qt)
LIBS += $$moduleDep(sdk,dox-qt)
LIBS += $$moduleDep(sdk,uicontrols-qt)
LIBS += $$moduleDep(astro,sweph)
LIBS += $$moduleDep(sdk,network-qt)
LIBS += $$moduleDep(sdk,arch)

android: {
    ANDROID_EXTRA_LIBS += $$androidModuleBuildPath(sdk,arch)
    ANDROID_EXTRA_LIBS += $$androidModuleBuildPath(sdk,network-qt)
    ANDROID_EXTRA_LIBS += $$androidModuleBuildPath(astro,sweph)
    ANDROID_EXTRA_LIBS += $$androidModuleBuildPath(sdk,uicontrols-qt)
    ANDROID_EXTRA_LIBS += $$androidModuleBuildPath(sdk,dox-qt)
    ANDROID_EXTRA_LIBS += $$androidModuleBuildPath(astro,uicontrols-qt)
}

QMAKE_EXTRA_TARGETS += $$object_dep_on_module_header(main)

#include($${BUILD_ROOT}/sdk/build/qmake/qm-compile.pri)

FORMS += \
    mainwindow.ui
