
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
                mainScreenLoader.source = "/MainScreen.qml"
            }
        }

        Page {
            ProcessView {
                id: mainProcess
                anchors.fill: parent

                DocumentScreen {
                    id: documentScreen
                    currentDocument: mainScreenLoader.item !== null ? mainScreenLoader.item.horaDocument : null
                    onDocumentLoaded: {
                        mainProcess.currentIndex = 1
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
                }
            }

            footer: ToolBar {
                id: pagerFrame
                Row {
                    anchors.centerIn: parent
                    spacing: 20
                    Repeater {
                        model: mainProcess.count
                        delegate: ToolButton {
                            icon.source: iconSources[index]
                            icon.height: pagerFrame.height
                            icon.width: pagerFrame.height
                            property var iconSources: [
                                "/icons/doc_empty_icon&32.png",
                                "/icons/target_icon&32.png",
                                "/icons/cog_icon&32.png"
                            ]
                            highlighted: index === mainProcess.currentIndex
                            onClicked: mainProcess.currentIndex = index
                        }
                    }
                }
            }
        }
    }
}
