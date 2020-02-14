
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

ANDROID_EXTRA_LIBS += /home/robert/code/symboid/_build/debug-android_armv7-qt5.12/sdk/arch/libsdk-arch.so
ANDROID_EXTRA_LIBS += /home/robert/code/symboid/_build/debug-android_armv7-qt5.12/sdk/network-qt/libsdk-network-qt.so
ANDROID_EXTRA_LIBS += /home/robert/code/symboid/_build/debug-android_armv7-qt5.12/sdk/uicontrols-qt/libsdk-uicontrols-qt.so
ANDROID_EXTRA_LIBS += /home/robert/code/symboid/_build/debug-android_armv7-qt5.12/astro/sweph/libastro-sweph.so
ANDROID_EXTRA_LIBS += /home/robert/code/symboid/_build/debug-android_armv7-qt5.12/sdk/dox-qt/libsdk-dox-qt.so
ANDROID_EXTRA_LIBS += /home/robert/code/symboid/_build/debug-android_armv7-qt5.12/astro/uicontrols-qt/libastro-uicontrols-qt.so

QMAKE_EXTRA_TARGETS += $$object_dep_on_module_header(main)

#include($${BUILD_ROOT}/sdk/build/qmake/qm-compile.pri)

FORMS += \
    mainwindow.ui
