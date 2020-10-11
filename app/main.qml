
import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Window 2.12
import QtQuick.Controls.Material 2.3
import QtQuick.Controls.Universal 2.3
import Symboid.Sdk.Controls 1.0
import Symboid.Sdk.Hosting 1.0
import "." as Csillagvarta

ApplicationWindow {
    id: mainWindow

    visible: true

    visibility: Window.Maximized
    width: 900
    height: 600

    Material.theme: Material.Light
    Material.primary: "#95B2A0"
    Material.accent: "#C94848"

    Universal.accent: Universal.Emerald

    signal settingsClicked
    onSettingsClicked: loadProcess.currentIndex = 2

    ProcessView {
        id: loadProcess
        anchors.fill: parent

        LoadScreen {

            onLoadMainScreen: {
                mainScreenLoader.source = "/MainScreen.qml"
            }

        }

        Loader {
            id: mainScreenLoader
            onLoaded: {
                console.info("Main screen loaded.")
                loadProcess.currentIndex = 1
            }
        }

        Csillagvarta.SettingsScreen {
            onBackClicked: loadProcess.currentIndex = 1
        }
    }
}
