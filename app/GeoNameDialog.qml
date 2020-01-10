
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Symboid.Astro.Controls 1.0

Dialog {
    title: qsTr("Select geographic location")

    Flow {
        anchors.fill: parent

        Column {
            padding: 20
            spacing: 10
//            Row {
//                spacing: parent.spacing
            Label {
//                anchors.verticalCenter: parent.verticalCenter
                text: qsTr("Select current geographic location")
//                }
                RoundButton {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.right
                    width: parent.parent.padding * 2 + 1
                    height: width
                }
            }
        }

        Rectangle {
            width: 1
            height: parent.height
            color: "lightgray"
        }

        Column {
            Grid {
                columns: 2
                anchors.horizontalCenter: parent.horizontalCenter
                verticalItemAlignment: Grid.AlignVCenter
                spacing: 10
                padding: 30
                Text {
                    text: qsTr("Geographic lattitude:")
                }
                GeoCoordBox {
                    id: currGeoLatt
                    editable: false
                }
                Text {
                    text: qsTr("Geographic longitude:")
                }
                GeoCoordBox {
                    id: currGeoLont
                    editable: false
                }
            }
        }
    }

    opacity: 0.5

    standardButtons: Dialog.Ok | Dialog.Cancel
}
