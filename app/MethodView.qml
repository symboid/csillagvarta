
import QtQuick 2.12
import Symboid.Sdk.Controls 1.0

FolderView {

    signal loadRadixView
    signal loadDocView(string viewName)

    property FolderView folderView: this
    initialItem: FolderPane {
        MethodItem {
            title: qsTr("Natal horoscope")
            onLoadClicked: loadRadixView()
        }
        MethodItem {
            title: qsTr("Forecast tabulars")
            onLoadClicked: loadDocView("ForecastScreen.qml")
        }
        MethodItem {
            title: qsTr("Revolution")
            onLoadClicked: loadDocView("RevolutionScreen.qml")
        }
        MethodItem {
            title: qsTr("Synastry")
            onLoadClicked: loadDocView("SynastryScreen.qml")
        }
    }
}
