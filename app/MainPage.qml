
import QtQuick 2.12
import QtQuick.Controls 2.5
import Symboid.Sdk.Controls 1.0
import Symboid.Sdk.Hosting 1.0
import Symboid.Sdk.Dox 1.0
import "." as Csillagvarta
import QtQuick.Layouts 1.3

ProcessPage {

    property Document mainDocument: Document {
        title: radixScreen.horaTitle
        onTitleChanged: {
            radixScreen.horaTitle = title
            title = Qt.binding(function(){return radixScreen.horaTitle})
        }
        onLoadStarted: radixScreen.autocalc = false
        onLoadFinished: radixScreen.autocalc = true
        onLoadFailed: radixScreen.autocalc = true

        DocumentNode {
            name: "radix"

            property alias title: radixScreen.horaTitle

            DocumentNode {
                name: "time"
                property alias year: radixScreen.horaYear
                property alias month: radixScreen.horaMonth
                property alias day: radixScreen.horaDay
                property alias hour: radixScreen.horaHour
                property alias minute: radixScreen.horaMinute
                property alias second: radixScreen.horaSecond
                property alias calendarType: radixScreen.horaCalendarType
            }
            DocumentNode {
                name: "geoLoc"
                property alias geoName: radixScreen.horaGeoName
                property alias latt: radixScreen.horaGeoLatt
                property alias lont: radixScreen.horaGeoLont
                property alias tzDiff: radixScreen.horaGeoTzDiff
            }
        }

        onLoadCurrent: {
            radixScreen.setCurrent()
        }
    }

    ProcessView {
        id: mainProcess
        anchors.fill: parent
        currentIndex: 2

        DocumentFolderScreen {
            id: documentFolderScreen
            currentDocument: mainDocument
            onDocumentLoaded: {
                mainProcess.currentIndex = 2
            }
        }

        MethodsScreen {
            onLoadRadixView: {
                viewSelector.currentIndex = 0
                mainProcess.currentIndex = 2
            }
            onLoadDocView: {
                viewSelector.currentIndex = 1
                mainProcess.currentIndex = 2
            }
        }

        StackLayout {
            id: viewSelector
            currentIndex: 0
            RadixScreen {
                id: radixScreen
                onSaveDocument: {
                    if (mainDocument.save())
                    {
                        documentFolderScreen.refresh()
                        infoPopup.show(qsTr("Horoscope of '%1' saved.").arg(radixTitle))
                    }
                    else
                    {
                        errorPopup.show(qsTr("Failed to save horoscope of '%1'!").arg(radixTitle))
                    }
                }
            }
            ForecastScreen {
                radixHora: radixScreen.hora
            }

            HomeScreen {
                id: homeScreen
                source: "qrc:/HoraViewScreen.qml"
            }
        }

        DocumentScreen {
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
                        "/icons/calc_icon&32.png",
                        "/icons/home_icon&32.png",
                        "/icons/doc_lines_icon&32.png",
                        "/icons/cog_icon&32.png"
                    ]
                    highlighted: index === mainProcess.currentIndex
                    onClicked: mainProcess.currentIndex = index
                }
            }
        }
    }
}
