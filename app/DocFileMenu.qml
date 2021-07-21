
import QtQuick 2.12
import QtQuick.Controls 2.5
import Symboid.Sdk.Controls 1.0

FolderView {
    id: docFileMenu

    signal methodClicked

    signal methodNewClicked
    signal methodSaveClicked
    signal methodPrintClicked
    signal methodExportClicked
    signal methodCloseClicked

    property FolderView folderView: this
    initialItem: FolderPane {
        width: docFileMenu.width
        FolderItem {
            title: qsTr("New (Radix)")
            rightItem: ToolButton {
                icon.source: "/icons/doc_new_icon&32.png"
                onClicked: { methodClicked(); methodNewClicked() }
            }
        }
        FolderItem {
            title: qsTr("Save")
            rightItem: ToolButton {
                icon.source: "/icons/save_icon&32.png"
                onClicked: { methodClicked(); methodSaveClicked() }
            }
        }
        FolderItem {
            title: qsTr("Print")
            rightItem: ToolButton {
                icon.source: "/icons/print_icon&32.png"
                onClicked: { methodClicked(); methodPrintClicked() }
            }
        }
        FolderItem {
            title: qsTr("Save to image")
            rightItem: ToolButton {
                icon.source: "/icons/shapes_icon&32.png"
                onClicked: { methodClicked(); methodExportClicked() }
            }
        }
        FolderItem {
            title: qsTr("Close")
            rightItem: ToolButton {
                icon.source: "/icons/delete_icon&32.png"
                onClicked: { methodClicked(); methodCloseClicked() }
            }
        }
    }
}
