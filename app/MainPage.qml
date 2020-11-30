
import QtQuick 2.12
import QtQuick.Controls 2.5
import Symboid.Sdk.Controls 1.0
import Symboid.Sdk.Hosting 1.0
import Symboid.Sdk.Dox 1.0
import "." as Csillagvarta

Page {
    ProcessView {
        id: mainProcess
        anchors.fill: parent

        DocumentScreen {
            id: documentScreen
            currentDocument: mainScreen.horaDocument
            onDocumentLoaded: {
                mainProcess.currentIndex = 1
            }
        }

        Csillagvarta.MainScreen {
            id: mainScreen
            onDocumentSaved: documentScreen.refresh()
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
