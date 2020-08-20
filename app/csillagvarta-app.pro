
TARGET = csillagvarta-app
BUILD_ROOT=../..
COMPONENT_NAME=csillagvarta
include($${BUILD_ROOT}/sdk/build/qmake/application.pri)

SOURCES += \
    main.cc

HEADERS += \
    init.h \
    setup.h \
    defs.h

RESOURCES += \
    csillagvarta-app.qrc

LIBS += $$moduleDep(astro,hora)
LIBS += $$moduleDep(astro,db)
LIBS += $$moduleDep(astro,uicontrols-qt)
LIBS += $$moduleDep(sdk,dox)
LIBS += $$moduleDep(sdk,hosting)
LIBS += $$moduleDep(sdk,uicontrols-qt)
LIBS += $$moduleDep(sdk,network)
LIBS += $$moduleDep(sdk,arch)

android: {
    ANDROID_EXTRA_LIBS += $$androidModuleBuildPath(sdk,arch)
    ANDROID_EXTRA_LIBS += $$androidModuleBuildPath(sdk,network)
    ANDROID_EXTRA_LIBS += $$androidModuleBuildPath(sdk,uicontrols-qt)
    ANDROID_EXTRA_LIBS += $$androidModuleBuildPath(sdk,hosting)
    ANDROID_EXTRA_LIBS += $$androidModuleBuildPath(sdk,dox)
    ANDROID_EXTRA_LIBS += $$androidModuleBuildPath(astro,uicontrols-qt)
    ANDROID_EXTRA_LIBS += $$androidModuleBuildPath(astro,db)
    ANDROID_EXTRA_LIBS += $$androidModuleBuildPath(astro,hora)
}

QMAKE_EXTRA_TARGETS += $$object_dep_on_component_header(main)

include($${BUILD_ROOT}/astro/db/sweph/ephe/files.pri)
