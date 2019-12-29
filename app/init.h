
#ifndef __SYMBOID_CSILLAGVARTA_APP_INIT_H__
#define __SYMBOID_CSILLAGVARTA_APP_INIT_H__

#include "csillagvarta/app/defs.h"
#include "sdk/arch/appqml.h"
#include "qstro/eph/init.h"
#include "qstro/calculo/init.h"

struct app_csillagvarta : arh::app_qml<app_csillagvarta>
{
    APP_OBJECT(csillagvarta)

    app_csillagvarta(int* _argc, char*** _argv) : arh::app_qml<app_csillagvarta>(_argc, _argv)
    {
    }

    arh::mod_init<mod_qstro_eph> _M_mod_qstro_eph;
    arh::mod_init<mod_qstro_calculo> _M_mod_qstro_calculo;
};

#endif // __SYMBOID_CSILLAGVARTA_APP_INIT_H__
