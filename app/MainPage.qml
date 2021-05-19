
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
        currentIndex: 1

        DocumentFolderScreen {
            id: documentScreen
            currentDocument: radixScreen.horaDocument
            onDocumentLoaded: {
                mainProcess.currentIndex = 1
            }
        }

        Csillagvarta.RadixScreen {
            id: radixScreen
            onDocumentSaved: documentScreen.refresh()
        }

        DocumentScreen {
        }

        Csillagvarta.HoraViewScreen {
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
                        "/icons/home_icon&32.png",
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
