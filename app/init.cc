
#include "csillagvarta/app/setup.h"
#include "csillagvarta/app/init.h"
#include <qglobal.h>

app_csillagvarta::app_csillagvarta(int* _argc, char*** _argv)
    : arh::app_qml<app_csillagvarta>(_argc, _argv)
{
    Q_INIT_RESOURCE(csillagvarta_app);
    load_translator();
}

app_csillagvarta::~app_csillagvarta()
{
    Q_CLEANUP_RESOURCE(csillagvarta_app);
}
