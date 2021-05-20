
import QtQuick 2.12
import QtQuick.Controls 2.5
import Symboid.Sdk.Dox 1.0
import Symboid.Sdk.Controls 1.0

FolderScreen {
    id: documentScreen
    initialTitle: qsTr("Calculation methods")
    property alias settingsView: documentScreen.folderView

    MethodItem {
        title: qsTr("Natal horoscope")
    }

    FolderGroupFixed {
        title: qsTr("Forecasts")
        MethodItem {
            title: qsTr("Primary direction")
        }
        MethodItem {
            title: qsTr("Transit")
        }
    }

    FolderGroupFixed {
        title: qsTr("Revolutions")
        MethodItem {
            title: qsTr("Solar horoscope")
        }
        MethodItem {
            title: qsTr("Lunar horoscope")
        }
    }
}
