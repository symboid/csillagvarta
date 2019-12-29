
#include "sdk/app/init.h"
#include "sdk/dox/init.h"
#include "astro/calculo/init.h"
#include "astro/ephe/init.h"
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#ifndef Q_OS_IOS
#include "csillagvarta/app/module.h"
#endif

int main(int argc, char *argv[])
{
    int result = 0;

    QGuiApplication app(argc, argv);

    {
        QQuickStyle::setStyle("Universal");

        QQmlApplicationEngine engine;

        const char* mainScreenTypeName = "MainScreen";
        QUrl mainScreenQmlPath(QString("qrc:///%1.qml").arg(mainScreenTypeName));
        qmlRegisterType(mainScreenQmlPath, "Symboid.Sdk.App", 1, 0, mainScreenTypeName);
        engine.addImportPath("qrc:///");

        initSdkApp();
        initSdkDox();
        initAstroEphe();
        initAstroCalculo();

        engine.load(QUrl("qrc:///Symboid/Sdk/App/main/MainAppWindow.qml"));
        result = app.exec();
    }

    return result;
}
