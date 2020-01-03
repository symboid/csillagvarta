import QtQuick 2.12
import QtQuick.Controls 2.5
import Symboid.Astro.Eph 1.0
import Symboid.Astro.Calculo 1.0

ApplicationWindow {
    id: mainWindow
    visible: true

    x:0
    y:0
    width: screen.desktopAvailableWidth
    height: screen.desktopAvailableHeight

    Flickable {
        anchors.fill: parent
        flickableDirection: horaScreen.isLandscape ? Flickable.HorizontalFlick : Flickable.VerticalFlick
        contentWidth: horaScreen.width
        contentHeight: horaScreen.height
        HoraScreen {
            id: horaScreen
            isLandscape: mainWindow.width > mainWindow.height
            mandalaSize: isLandscape ? mainWindow.height : mainWindow.width
            screenSize: isLandscape ? mainWindow.width : mainWindow.height
            showDetails: details.checked
        }
    }

    Switch {
        id: details
        anchors {
            bottom: parent.bottom
            bottomMargin: 20
            right: parent.right
            rightMargin: 20
        }
        text: qsTr("Details")
    }
}
