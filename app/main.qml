import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Window 2.12
import Symboid.Sdk.Controls 1.0
import Symboid.Astro.Controls 1.0
import Symboid.Sdk.Dox 1.0
import QtQuick.Controls.Material 2.3
import QtQuick.Controls.Universal 2.3

ApplicationWindow {
    id: mainWindow
    visible: true

    x:0
    y:0
    width: screen.desktopAvailableWidth
    height: screen.desktopAvailableHeight

    Material.theme: Material.Light
    Material.primary: Material.Green
    Material.accent: Material.Red

    Universal.accent: Universal.Emerald

    header: ToolBar {
        ToolButton {
            icon.source: "/icons/doc_lines_icon&32.png"
            onClicked: documentDialog.open()
        }
        ToolButton {
            icon.source: "/icons/cog_icon&32.png"
            anchors.right: parent.right
        }
//        Material.primary: "#CFE2D7"
        Material.primary: "#95B2A0"
    }

    Column {
        id: hunFlag
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        Repeater {
            model: 3
            delegate: Rectangle {
                anchors.left: parent.left
                anchors.right: parent.right
                height: 2
                readonly property var flagColor: [ "red", "white", "green" ]
                color: flagColor[index]
            }
        }
    }

    HoraScreen {
        id: horaScreen
        anchors {
            top: hunFlag.bottom
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }

        fontPointSize: mainWindow.font.pointSize
    }

    DocumentDialog {
        id: documentDialog
        width: Math.min(400, parent.width)
        height: parent.height
        edge: Qt.LeftEdge

//        Material.background: "#DFEEE5"
//        opacity: 0.875
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
