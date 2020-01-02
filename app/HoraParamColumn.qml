
import QtQuick 2.12
import QtQuick.Controls 2.5

Column {
    property alias title: titleLabel.text

    padding: 20

    Label {
        id: titleLabel
        text: qsTr("Date and time")
        font.italic: true
//        topPadding: 10
//        bottomPadding: 10
    }
}
