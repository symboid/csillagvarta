
#ifndef __SYMBOID_CSILLAGVARTA_APP_INIT_H__
#define __SYMBOID_CSILLAGVARTA_APP_INIT_H__

#include "csillagvarta/app/defs.h"
#include "sdk/arch/appqml.h"
#include "sdk/network/init.h"
#include "sdk/uicontrols-qt/init.h"
#include "sdk/hosting/init.h"
#include "sdk/dox/init.h"
#include "astro/db/init.h"
#include "astro/uicontrols-qt/init.h"

struct app_csillagvarta : arh::app_qml<app_csillagvarta>
{
    APP_OBJECT(csillagvarta)

    app_csillagvarta(int* _argc, char*** _argv)
        : arh::app_qml<app_csillagvarta>(_argc, _argv)
    {
    }

    arh::mod_init<mod_sdk_network> _M_mod_sdk_network;
    arh::mod_init<mod_sdk_uicontrols_qt> _M_mod_sdk_uicontrols_qt;
    arh::mod_init<mod_sdk_hosting> _M_mod_sdk_hosting;
    arh::mod_init<mod_sdk_dox> _M_mod_sdk_dox;
    arh::mod_init<mod_astro_db> _M_mod_astro_db;
    arh::mod_init<mod_astro_uicontrols_qt> _M_mod_astro_uicontrols_qt;
};

#endif // __SYMBOID_CSILLAGVARTA_APP_INIT_H__
