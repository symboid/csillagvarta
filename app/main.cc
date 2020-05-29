
#include "csillagvarta/app/defs.h"
#include "sdk/arch/mainobject.h"
#include "csillagvarta/app/init.h"
#include <QQuickStyle>

int main(int _argc, char* _argv[])
{
    arh::main_object_init<app_csillagvarta, int*, char***> app(&_argc, &_argv);
    app->setName("CsillagVarta");
    QQuickStyle::setStyle("Material");
    return app->run();
}
