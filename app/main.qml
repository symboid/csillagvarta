
import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Window 2.12
import QtQuick.Controls.Material 2.3
import QtQuick.Controls.Universal 2.3
import Symboid.Sdk.Controls 1.0
import Symboid.Sdk.Hosting 1.0
import Symboid.Sdk.Dox 1.0
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

    Universal.accent: "#C94848"

    ProcessView {
        id: loadProcess
        anchors.fill: parent
        LoadScreen {
            onLoadMainScreen: {
                mainScreenLoader.source = "/MainPage.qml"
            }
        }

        Loader {
            id: mainScreenLoader
            onLoaded: {
                console.info("Main page loaded.")
                loadProcess.currentIndex = 1
            }
        }
    }
}
