import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Window 2.12
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

    Grid {
        columns: 2
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        spacing: 10
        padding: 10
        opacity: 0.25
        property int pxPerCm: screen.pixelDensity * 10

        Text { text: "size:" } Text { text: screen.width + " x " + screen.height }
        Text { text: "px/cm:" } Text { text: parent.pxPerCm }
        Text { text: "px ratio:" } Text { text: screen.devicePixelRatio  }
        Text { text: "size (cm):" } Text { text: numberPrec(screen.width / parent.pxPerCm, 1) + " x " + numberPrec(screen.height / parent.pxPerCm, 1) }
    }
    function numberPrec(num,prec)
    {
        return Number(num).toLocaleString(Qt.locale(), 'f', prec)
    }
}
