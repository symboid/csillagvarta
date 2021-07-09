
import QtQuick 2.12
import QtQuick.Controls 2.5
import Symboid.Sdk.Controls 1.0
import Symboid.Sdk.Hosting 1.0
import Symboid.Sdk.Dox 1.0
import "." as Csillagvarta

ProcessPage {

    ProcessView {
        id: mainProcess
        anchors.fill: parent
        currentIndex: homeIndex
        property int homeIndex: 1

        DocumentFolderScreen {
            id: documentFolderScreen
            currentDocument: browserScreen.mainDocument
            onDocumentLoaded: {
                mainProcess.currentIndex = mainProcess.homeIndex
            }
        }

        BrowserScreen {
            id: browserScreen
        }

        Csillagvarta.SettingsScreen {
        }
    }

    footer: ToolBar {
        Row {
            anchors.centerIn: parent
            ToolButton {
                icon.source: "/icons/folder_open_icon&32.png"
                width: 80
                highlighted: mainProcess.currentIndex === 0
                onClicked: mainProcess.currentIndex = 0
            }
            Loader {
                sourceComponent: mainProcess.currentIndex === mainProcess.homeIndex ? browserScreen.buttonRow : homeButton
                Component {
                    id: homeButton
                    ToolButton {
                        icon.source: "/icons/home_icon&32.png"
                        width: 80
                        onClicked: mainProcess.currentIndex = mainProcess.homeIndex
                    }
                }
            }
            ToolButton {
                icon.source: "/icons/cog_icon&32.png"
                width: 80
                highlighted: mainProcess.currentIndex === 2
                onClicked: mainProcess.currentIndex = 2
            }
        }
    }
}
