
#ifndef __SYMBOID_CSILLAGVARTA_APP_INIT_H__
#define __SYMBOID_CSILLAGVARTA_APP_INIT_H__

#include "csillagvarta/app/defs.h"
#include "sdk/arch/appqml.h"
#include "sdk/hosting/init.h"
#include "astro/uicontrols-qt/init.h"
#include "sdk/dox-qt/init.h"

struct app_csillagvarta : arh::app_qml<app_csillagvarta>
{
    APP_OBJECT(csillagvarta)

    app_csillagvarta(int* _argc, char*** _argv)
        : arh::app_qml<app_csillagvarta>(_argc, _argv)
    {
    }

    arh::mod_init<mod_sdk_hosting> _M_mod_sdk_hosting;
    arh::mod_init<mod_astro_uicontrols_qt> _M_mod_astro_uicontrols_qt;
    arh::mod_init<mod_sdk_dox_qt> _M_mod_sdk_dox_qt;
};

#endif // __SYMBOID_CSILLAGVARTA_APP_INIT_H__
