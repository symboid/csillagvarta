
import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Window 2.12
import QtQuick.Controls.Material 2.3
import QtQuick.Controls.Universal 2.3
import Symboid.Sdk.Controls 1.0
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

    ProcessView {
        id: loadProcess
        anchors.fill: parent

        Item {
            Label {
                anchors.centerIn: parent
                text: qsTr("Loading...")
                font {
                    pointSize: 36
                    italic: true
                    bold: true
                }
            }

            Timer {
                interval: 100
                running: true
                onTriggered: {
                    console.info("Loading main screen...")
                    mainScreenLoader.source = "/MainScreen.qml"
                }
            }
        }

        Loader {
            id: mainScreenLoader
            onLoaded: {
                console.info("Main screen loaded.")
                loadProcess.currentIndex = 1
            }
        }

    }
}
