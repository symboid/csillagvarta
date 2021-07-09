
import QtQuick 2.12
import QtQuick.Controls 2.5
import Symboid.Sdk.Controls 1.0

Popup {

    signal loadRadixView
    signal loadDocView(string viewName)

    onLoadRadixView: close()
    onLoadDocView: close()

    FolderView {
        id: folderView
        anchors.fill: parent
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
}
