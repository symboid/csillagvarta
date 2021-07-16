
import QtQuick 2.12
import Symboid.Sdk.Controls 1.0

FolderView {

    property int openPageCount: 0
    signal switchDocPage(int pageIndex)

    property FolderView folderView: this
    initialItem: FolderPane {
        Repeater {
            model: openPageCount
            MethodItem {
                title: qsTr("DOC PAGE")
                onLoadClicked: switchDocPage(index)
            }
        }
    }
}
