
include (../build/qmake/deps.pri)

SUBDIRS = \
    $$module_dep(sdk,basics) \
    $$module_dep(sdk,app) \
    $$module_dep(sdk,dox) \
    $$module_dep(astro,ephe) \
    $$module_dep(astro,sweph) \
    $$module_dep(astro,eph) \
    $$module_dep(astro,eph-test) \
    $$module_dep(astro,calculo) \
    $$module_dep(csillagvarta,app)
