import QtQuick 2.12
import QtQuick.Controls 2.5
import Symboid.Astro.Eph 1.0
import Symboid.Astro.Calculo 1.0

ApplicationWindow {
    visible: true

    x:0
    y:0
    width: screen.desktopAvailableWidth
    height: screen.desktopAvailableHeight

    HoraScreen {
        anchors.fill: parent
        showDetails: details.checked
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
