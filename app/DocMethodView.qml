
import QtQuick 2.12
import Symboid.Sdk.Controls 1.0

FolderView {

    signal loadMethod(string methodPage)

    property FolderView folderView: this
    initialItem: FolderPane {
        DocMethodItem {
            title: qsTr("Forecast tabulars")
            onLoadClicked: loadMethod("qrc:/ForecastScreen.qml")
        }
        DocMethodItem {
            title: qsTr("Revolution")
            onLoadClicked: loadMethod("qrc:/RevolutionScreen.qml")
        }
        DocMethodItem {
            title: qsTr("Synastry")
            onLoadClicked: loadMethod("qrc:/SynastryScreen.qml")
        }
    }
}
