
#ifndef __SYMBOID_CSILLAGVARTA_APP_INIT_H__
#define __SYMBOID_CSILLAGVARTA_APP_INIT_H__

#include "csillagvarta/app/defs.h"
//#define APP_QML
#ifdef APP_QML
#   include "sdk/arch/appqml.h"
template <class _App>
using app_base = arh::app_qml<_App>;
#else
#   include "sdk/arch/appqtw.h"
#   include "csillagvarta/app/mainwindow.h"
template <class _App>
using app_base = arh::app_qtw<_App,MainWindow>;
#endif
#include "qstro/eph/init.h"
#include "qstro/calculo/init.h"

struct app_csillagvarta : app_base<app_csillagvarta>
{
    APP_OBJECT(csillagvarta)

    app_csillagvarta(int* _argc, char*** _argv)
        : app_base<app_csillagvarta>(_argc, _argv)
    {
    }

    arh::mod_init<mod_qstro_eph> _M_mod_qstro_eph;
    arh::mod_init<mod_qstro_calculo> _M_mod_qstro_calculo;
};

#endif // __SYMBOID_CSILLAGVARTA_APP_INIT_H__
