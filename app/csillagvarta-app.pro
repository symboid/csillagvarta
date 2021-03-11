
TARGET = csillagvarta-app
BUILD_ROOT=../..
COMPONENT_NAME=csillagvarta
include($${BUILD_ROOT}/build/qmake/application.pri)

SOURCES += \
    init.cc \
    main.cc

HEADERS += \
    init.h \
    setup.h \
    defs.h

RESOURCES += \
    csillagvarta-app.qrc

LIBS += $$moduleDep(astro,hora)
LIBS += $$moduleDep(astro,db)
LIBS += $$moduleDep(astro,controls)
LIBS += $$moduleDep(sdk,dox)
LIBS += $$moduleDep(sdk,hosting)
LIBS += $$moduleDep(sdk,controls)
LIBS += $$moduleDep(sdk,network)
LIBS += $$moduleDep(sdk,arch)

android: {
    ANDROID_EXTRA_LIBS += $$androidModuleBuildPath(sdk,arch)
    ANDROID_EXTRA_LIBS += $$androidModuleBuildPath(sdk,network)
    ANDROID_EXTRA_LIBS += $$androidModuleBuildPath(sdk,controls)
    ANDROID_EXTRA_LIBS += $$androidModuleBuildPath(sdk,hosting)
    ANDROID_EXTRA_LIBS += $$androidModuleBuildPath(sdk,dox)
    ANDROID_EXTRA_LIBS += $$androidModuleBuildPath(astro,controls)
    ANDROID_EXTRA_LIBS += $$androidModuleBuildPath(astro,db)
    ANDROID_EXTRA_LIBS += $$androidModuleBuildPath(astro,hora)
}

QMAKE_EXTRA_TARGETS += $$object_dep_on_component_header(main)

include($${BUILD_ROOT}/astro/db/sweph/ephe/files.pri)

!CONFIG(component_api) {
$$copySwephFile(sefstars,txt)
$$copySwephFile(seplm30,se1)
$$copySwephFile(seplm12,se1)
$$copySwephFile(seplm06,se1)
$$copySwephFile(sepl_00,se1)
$$copySwephFile(sepl_06,se1)
$$copySwephFile(sepl_12,se1)
$$copySwephFile(sepl_18,se1)
}
