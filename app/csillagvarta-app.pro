
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

LIBS += $$externDep(astro,hora)
LIBS += $$externDep(astro,db)
LIBS += $$externDep(astro,controls)
LIBS += $$externDep(sdk,dox)
LIBS += $$externDep(sdk,hosting)
LIBS += $$externDep(sdk,controls)
LIBS += $$externDep(sdk,network)
LIBS += $$externDep(sdk,arch)

android: {
    ANDROID_EXTRA_LIBS += $$externPath(sdk,arch)
    ANDROID_EXTRA_LIBS += $$externPath(sdk,network)
    ANDROID_EXTRA_LIBS += $$externPath(sdk,controls)
    ANDROID_EXTRA_LIBS += $$externPath(sdk,hosting)
    ANDROID_EXTRA_LIBS += $$externPath(sdk,dox)
    ANDROID_EXTRA_LIBS += $$externPath(astro,controls)
    ANDROID_EXTRA_LIBS += $$externPath(astro,db)
    ANDROID_EXTRA_LIBS += $$externPath(astro,hora)
}

QMAKE_EXTRA_TARGETS += $$object_dep_on_component_header(main)

!CONFIG(component_api) {
include($${BUILD_ROOT}/astro/db/sweph/ephe/files.pri)
$$copySwephFile(sefstars,txt)
$$copySwephFile(seplm30,se1)
$$copySwephFile(seplm12,se1)
$$copySwephFile(seplm06,se1)
$$copySwephFile(sepl_00,se1)
$$copySwephFile(sepl_06,se1)
$$copySwephFile(sepl_12,se1)
$$copySwephFile(sepl_18,se1)
}


msvc {
api_app_assets.files = $$shell_path($$SYS_HOME/csillagvarta/deploy/csillagvarta.nsi)
}
api_app_assets.path = /assets
INSTALLS += api_app_assets
