
import QtQuick 2.12
import QtQuick.Controls 2.5
import Symboid.Sdk.Controls 1.0 as UiControls
import Symboid.Astro.Controls 1.0

UiControls.SettingsScreen {
    UiControls.SoftwarePane {

    }

    HoraElementsPane {

    }

    UiControls.SettingsPane {
        title: qsTr("Orbis")
/*        Rectangle {
            border.width: 3
            border.color: "red"
//            anchors.centerIn: parent
            width: 200
            height: 200
        }
        */
    }
}
