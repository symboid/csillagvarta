import QtQuick 2.12
import QtQuick.Controls 2.5
import Symboid.Astro.Controls 1.0

ApplicationWindow {
    id: mainWindow
    visible: true

    x:0
    y:0
    width: screen.desktopAvailableWidth
    height: screen.desktopAvailableHeight

    HoraScreen {
        id: horaScreen
        anchors.fill: parent
        isLandscape: mainWindow.width > mainWindow.height
        mandalaSize: isLandscape ? mainWindow.height : mainWindow.width
        screenSize: isLandscape ? mainWindow.width : mainWindow.height
    }
}
