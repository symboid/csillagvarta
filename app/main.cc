
#include "csillagvarta/app/defs.h"
#include "sdk/arch/mainobject.h"
#include "csillagvarta/app/init.h"
#include <QSettings>
#include <QQuickStyle>
#include "csillagvarta/component.h"
#include "sdk/hosting/qsoftwareupdate.h"
#include "sdk/hosting/qappconfig.h"

int main(int _argc, char* _argv[])
{
    arh::main_object_init<app_csillagvarta, int*, char***> app(&_argc, &_argv);
    arh::main_object<QSoftwareUpdate> softwareUpdate;
    softwareUpdate->mAppSwid = COMPONENT_SWID;
    softwareUpdate->setAppVersion(COMPONENT_NAME, COMPONENT_VER_MAJOR, COMPONENT_VER_MINOR,
                        COMPONENT_VER_PATCH, COMPONENT_VER_SERIAL, COMPONENT_REV_ID);

    arh::main_object<QAppConfig> appConfig;
    QString st = appConfig->ui()->style();
    QQuickStyle::setStyle(appConfig->ui()->style());

    return app->run();
}
