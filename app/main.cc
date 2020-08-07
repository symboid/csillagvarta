
#include "csillagvarta/app/defs.h"
#include "sdk/arch/mainobject.h"
#include "csillagvarta/app/init.h"
#include <QQuickStyle>
#include "csillagvarta/component.h"
#include "sdk/hosting/qsoftwareupdate.h"

int main(int _argc, char* _argv[])
{
    arh::main_object_init<app_csillagvarta, int*, char***> app(&_argc, &_argv);
    app->setName("CsillagVarta");
    arh::main_object<QSoftwareUpdate> softwareUpdate;
    softwareUpdate->setAppVersion(
        COMPONENT_VER_MAJOR,
        COMPONENT_VER_MINOR,
        COMPONENT_VER_PATCH,
        COMPONENT_VER_SERIAL,
        COMPONENT_REV_ID);
    QQuickStyle::setStyle("Material");
    return app->run();
}
