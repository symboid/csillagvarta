import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Window 2.12
import Symboid.Sdk.Controls 1.0
import Symboid.Astro.Controls 1.0

ApplicationWindow {
    id: mainWindow
    visible: true

    x:0
    y:0
    width: screen.desktopAvailableWidth
    height: screen.desktopAvailableHeight

    header: ToolBar {
        id: toolbar
        ToolButton {
            icon.source: "file:///Users/robert/Munka/icons/black/png/folder_icon&32.png"
            icon.width: 32
            icon.height: 32
            onClicked: documentDialog.open()
        }
        ToolButton {
            icon.source: "file:///Users/robert/Munka/icons/black/png/cog_icon&32.png"
            icon.width: 32
            icon.height: 32
            anchors.right: parent.right
        }
    }

    HoraScreen {
        id: horaScreen
        anchors {
            top: toolbar.bottom
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }

        fontPointSize: mainWindow.font.pointSize
    }

    Drawer {

        id: documentDialog
        width: Math.min(400, parent.width)
        height: parent.height

        opacity: 0.875

        edge: Qt.LeftEdge

        DocItemOpsView {
            anchors.fill: parent
            leftAligned: documentDialog.edge === Qt.LeftEdge
            operations: Container {
                DocItemOp {
                    title: qsTr("Recent horoscopes")
                    control: Rectangle {
                        width: 100
                        height: 100
                        border.width: 1
                        border.color: "red"
                    }
                }
                DocItemOp {
                    title: qsTr("Current transit")
                }
                DocItemOp {
                    title: qsTr("Saved horoscopes")
                    control: Rectangle {
                        width: 100
                        height: 100
                        border.width: 1
                        border.color: "blue"
                    }
                }
            }
        }
    }

    /*
    Grid {
        columns: 2
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        spacing: 10
        padding: 10
        opacity: 0.25
        property int pxPerCm: screen.pixelDensity * 10

        Text { text: "size:" } Text { text: screen.width + " x " + screen.height }
        Text { text: "px/cm:" } Text { text: parent.pxPerCm }
        Text { text: "px ratio:" } Text { text: screen.devicePixelRatio  }
        Text { text: "size (cm):" } Text { text: numberPrec(screen.width / parent.pxPerCm, 1) + " x " + numberPrec(screen.height / parent.pxPerCm, 1) }
    }

    function numberPrec(num,prec)
    {
        return Number(num).toLocaleString(Qt.locale(), 'f', prec)
    }
    */
}
