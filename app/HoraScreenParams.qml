
import QtQuick 2.12
import QtQuick.Controls 2.5

Grid {
    property alias title: titleLabel.text

    width: parent.paramSectionWidth
    padding: 20
    spacing: 5
    columns: 1
    horizontalItemAlignment: Grid.AlignRight

    readonly property int defaultItemWidth: width - 3*padding

    Label {
        id: titleLabel
        width: parent.width - 2*parent.padding
        font.italic: true
    }
}
