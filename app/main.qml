import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Window 2.12
import Symboid.Sdk.Controls 1.0
import Symboid.Astro.Controls 1.0
import Symboid.Sdk.Dox 1.0
import QtQuick.Controls.Material 2.3
import QtQuick.Controls.Universal 2.3
import "." as Csillagvarta

ApplicationWindow {
    id: mainWindow
    visible: true

    visibility: Window.Maximized
    width: 900
    height: 600

    Material.theme: Material.Light
    Material.primary: Material.Green
    Material.accent: Material.Red

    Universal.accent: Universal.Emerald

    header: ToolBar {
        Row {
            ToolButton {
                icon.source: "/icons/doc_lines_icon&32.png"
                onClicked: horaDocumentDialog.open()
            }
            ToolButton {
                icon.source: "/icons/zoom_icon&32.png"
                onClicked: horaScreen.zoomToDefault()
            }
        }
        ToolButton {
            icon.source: "/icons/cog_icon&32.png"
            anchors.right: parent.right
            onClicked: processView.toggleSettingsScreen()
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

    ProcessView {
        id: processView
        anchors {
            top: hunFlag.bottom
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }

        readonly property int noScreenIndex: -1
        readonly property int horaScreenIndex: 0
        readonly property int settingsScreenIndex: 1
        property int lastScreenIndex: noScreenIndex

        function toggleSettingsScreen()
        {
            if (currentIndex !== settingsScreenIndex)
            {
                lastScreenIndex = currentIndex
                currentIndex = settingsScreenIndex
                horaScreen.interactive = false
            }
            else if (lastScreenIndex !== noScreenIndex)
            {
                currentIndex = lastScreenIndex
                horaScreen.interactive = true
            }
        }

        HoraScreen {
            id: horaScreen
            fontPointSize: mainWindow.font.pointSize
        }

        Csillagvarta.SettingsScreen {
            id: settingsScreen
        }
    }

    Document {
        id: horaDocument
        title: horaScreen.title

        DocumentNode {
            name: "radix"

            property alias title: horaScreen.title

            DocumentNode {
                name: "time"
                property alias year: horaScreen.year
                property alias month: horaScreen.month
                property alias day: horaScreen.day
                property alias hour: horaScreen.hour
                property alias minute: horaScreen.minute
                property alias second: horaScreen.second
                property alias calendarType: horaScreen.calendarType
            }
            DocumentNode {
                name: "geoLoc"
                property alias geoName: horaScreen.geoName
                property alias latt: horaScreen.geoLatt
                property alias lont: horaScreen.geoLont
                property alias tzDiff: horaScreen.geoTzDiff
            }
        }
        onLoadStarted: {
            horaScreen.unsetCurrent()
        }

        onLoadCurrent: {
            horaScreen.title = qsTr("Current Transit")
            horaScreen.setCurrent()
        }
    }
    HoraDocumentDialog {
        id: horaDocumentDialog
        currentDocument: horaDocument
        Material.background: "#DFEEE5"
        opacity: 0.875
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
