
import QtQuick 2.12
import QtQuick.Controls 2.5
import Symboid.Sdk.Controls 1.0

HoraViewScreen {

    showCurrent: showDetails
    signal saveDocument(string radixTitle)
    horaButton: RoundButton {
        radius: 5
        enabled: horaTitle !== ""
        display: RoundButton.IconOnly
        icon.source: "/icons/save_icon&32.png"
        icon.color: "#C94848"
        onClicked: saveDocument(horaTitle)
    }
    Component.onCompleted: {
        setCurrent()
        autocalc = true
    }
}
