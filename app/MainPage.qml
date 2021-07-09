
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
        id: pagerFrame
        readonly property int buttonCount: mainProcess.count
        readonly property int cellWidth: Math.min(mainProcess.width / buttonCount, 80)
        GridView {
            anchors.centerIn: parent
            height: pagerFrame.height
            width: pagerFrame.cellWidth * pagerFrame.buttonCount
            cellHeight: pagerFrame.height
            cellWidth: pagerFrame.cellWidth
            model: pagerFrame.buttonCount
            delegate: Item {
                height: pagerFrame.height
                width: pagerFrame.cellWidth
                ToolButton {
                    anchors.centerIn: parent
                    icon.source: iconSources[index]
                    property var iconSources: [
                        "/icons/folder_open_icon&32.png",
                        "/icons/home_icon&32.png",
                        "/icons/cog_icon&32.png"
                    ]
                    highlighted: index === mainProcess.currentIndex
                    onClicked: mainProcess.currentIndex = index
                }
            }
        }
    }
}
