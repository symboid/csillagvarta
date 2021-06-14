
import QtQuick 2.12
import QtQuick.Controls 2.5
import Symboid.Sdk.Dox 1.0
import Symboid.Sdk.Controls 1.0

FolderScreen {
    id: documentScreen
    initialTitle: qsTr("Calculation methods")
    property alias settingsView: documentScreen.folderView

    signal loadRadixView
    signal loadDocView(string viewName)

    MethodItem {
        title: qsTr("Natal horoscope")
        onLoadClicked: loadRadixView()
    }

    FolderGroupFixed {
        title: qsTr("Forecasts")
        MethodItem {
            title: qsTr("Primary direction")
            onLoadClicked: loadDocView("ForecastScreen.qml")
        }
        MethodItem {
            title: qsTr("Synastry")
            onLoadClicked: loadDocView("SynastryScreen.qml")
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
        MethodItem {
            title: qsTr("Generic")
            onLoadClicked: loadDocView("RevolutionScreen.qml")
        }
    }
}
