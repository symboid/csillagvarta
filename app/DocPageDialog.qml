
import QtQuick 2.12
import QtQuick.Controls 2.5
import Symboid.Sdk.Controls 1.0
import Symboid.Sdk.Dox 1.0

Popup {
    id: docPageDialog

    signal loadMethodPage(string methodPage)
    signal loadDocView(string viewName)
    signal switchDocPage(int viewIndex)

    property alias docPageCount: docPageView.docPageCount

    property alias docListModel: documentSelector.model
    property alias selectedDocIndex: documentSelector.currentIndex
    property alias selectedDocTitle: documentSelector.editText

    TabBar {
        id: tabBar
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        TabButton {
            icon.source: "/icons/align_just_icon&32.png"
        }
        TabButton {
            icon.source: "/icons/calc_icon&32.png"
        }
        TabButton {
            icon.source: "/icons/doc_lines_stright_icon&32.png"
        }
        TabButton {
            icon.source: "/icons/bookmark_1_icon&32.png"
        }
    }
    HorizontalLine {
        id: horizontalLine1
        anchors {
            top: tabBar.bottom
            left: parent.left
            right: parent.right
        }
    }
    Pane {
        id: documentPane
        anchors {
            top: horizontalLine1.bottom
            left: parent.left
            right: parent.right
        }
        height: documentSelector.height + topPadding + bottomPadding
        Row {
            spacing: documentPane.padding
            Label {
                id: documentLabel
                anchors.verticalCenter: parent.verticalCenter
                text: qsTr("Document") + ":"
                font.italic: true
            }
            ComboBox {
                id: documentSelector
                textRole: "radixTitle"
                width: documentPane.width - documentLabel.width - 3 * documentPane.padding
                editable: tabBar.currentIndex === 0
                enabled: tabBar.currentIndex !== 3
                font.italic: true
            }
        }
    }

    HorizontalLine {
        id: horizontalLine2
        anchors {
            top: documentPane.bottom
            left: parent.left
            right: parent.right
        }
    }

    signal methodNewClicked
    signal methodSaveClicked
    signal methodPrintClicked
    signal methodExportClicked
    signal methodCloseClicked

    SwitchView {
        currentIndex: tabBar.currentIndex
        anchors {
            top: horizontalLine2.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        DocFileMenu {
            id: docFileMenu
            onMethodClicked: close()
            onMethodNewClicked: docPageDialog.methodNewClicked()
            onMethodSaveClicked: docPageDialog.methodSaveClicked()
            onMethodPrintClicked: docPageDialog.methodPrintClicked()
            onMethodExportClicked: docPageDialog.methodExportClicked()
            onMethodCloseClicked: docPageDialog.methodCloseClicked()
        }
        DocMethodView {
            id: docMethodView
            onLoadMethod: {
                close()
                loadMethodPage(methodPage)
            }
        }
        DocPageView {
            id: docPageView
            onSwitchDocPage: docPageDialog.switchDocPage(pageIndex)
            onDocPageLoaded: close()
        }
    }
}
