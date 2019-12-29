
include (../sdk/build/qmake/deps.pri)

SUBDIRS = \
    $$module_dep(sdk,arch) \
    $$module_dep(sdk,network-qt) \
    $$module_dep(astro,eph) \
    $$module_dep(astro,sweph) \
    $$module_dep(astro,calculo) \
    $$module_dep(qstro,eph) \
    $$module_dep(qstro,calculo) \
    $$module_dep(csillagvarta,app)
