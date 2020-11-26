
#include "csillagvarta/app/setup.h"
#include "csillagvarta/app/init.h"
#include <qglobal.h>

app_csillagvarta::app_csillagvarta(int* _argc, char*** _argv)
    : arh::app_qml<app_csillagvarta>(_argc, _argv)
{
    Q_INIT_RESOURCE(csillagvarta_app);
    load_translator();

    arh::main_object<QHoraConfig> horaConfig;
    horaConfig->mPlanets.push_back(hor::planet(hor::planet::sun, new OrbisConfig(horaConfig->orbis(), 0)));
    horaConfig->mPlanets.push_back(hor::planet(hor::planet::moon, new OrbisConfig(horaConfig->orbis(), 1)));
    horaConfig->mPlanets.push_back(hor::planet(hor::planet::mercury, new OrbisConfig(horaConfig->orbis(), 2)));
    horaConfig->mPlanets.push_back(hor::planet(hor::planet::venus, new OrbisConfig(horaConfig->orbis(), 3)));
    horaConfig->mPlanets.push_back(hor::planet(hor::planet::mars, new OrbisConfig(horaConfig->orbis(), 4)));
    horaConfig->mPlanets.push_back(hor::planet(hor::planet::jupiter, new OrbisConfig(horaConfig->orbis(), 5)));
    horaConfig->mPlanets.push_back(hor::planet(hor::planet::saturn, new OrbisConfig(horaConfig->orbis(), 6)));

    horaConfig->mPlanets.push_back(hor::planet(hor::planet::uranus, new OrbisConfig(horaConfig->orbis(), 7)));
    horaConfig->mPlanets.push_back(hor::planet(hor::planet::neptune, new OrbisConfig(horaConfig->orbis(), 8)));
    horaConfig->mPlanets.push_back(hor::planet(hor::planet::pluto, new OrbisConfig(horaConfig->orbis(), 9)));

    horaConfig->mPlanets.push_back(hor::planet(hor::planet::dragon_head, new OrbisConfig(horaConfig->orbis(), 12)));
//    horaConfig->mPlanets.push_back(hor::planet(hor::planet::chiron, new hor::simple_orbis_config(0.5)));
    horaConfig->mPlanets.push_back(hor::planet(hor::planet::lilith, new hor::simple_orbis_config(1.5)));

}

app_csillagvarta::~app_csillagvarta()
{
    Q_CLEANUP_RESOURCE(csillagvarta_app);
}
