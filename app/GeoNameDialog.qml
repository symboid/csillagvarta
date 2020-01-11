
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Symboid.Astro.Controls 1.0

Drawer {
    opacity: 0.75

    Flickable {
        anchors.fill: parent
        flickableDirection: Flickable.VerticalFlick
        Column {
            id: searchGeoName
            anchors.left: parent.left
            anchors.right: parent.right
            Label {
                padding: 15
                font.italic: true
                font.bold: true
                text: qsTr("Geographic name lookup")
            }
            GeoNamesSearchBox {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: 15
                anchors.rightMargin: 15
                height: 500
            }
            Rectangle {
                width: parent.width
                height: 1
                color: "black"
            }
        }
    }
}
