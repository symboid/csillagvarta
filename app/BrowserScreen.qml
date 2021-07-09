
import QtQuick 2.12
import QtQuick.Controls 2.5
import Symboid.Sdk.Controls 1.0
import Symboid.Sdk.Dox 1.0

Page {
    id: browserScreen

    header: ToolBar {
        Row {
            anchors.horizontalCenter: parent.horizontalCenter

            ToolButton {
                icon.source: "/icons/br_prev_icon&32.png"
                enabled: browserStack.depth > 1
                onClicked: {
                    forwardStack.push(browserStack.pop())
                    forwardStackLength++
                }
            }
            ToolButton {
                icon.source: "/icons/calc_icon&32.png"
                onClicked: pageLoadDialog.open()
            }
            ToolButton {
                icon.source: "/icons/target_icon&32.png"
                enabled: false
            }
            ToolButton {
                icon.source: "/icons/doc_lines_icon&32.png"
                enabled: false
            }
            ToolButton {
                icon.source: "/icons/br_next_icon&32.png"
                enabled: forwardStackLength > 0
                onClicked: {
                    browserStack.push(forwardStack.pop())
                    forwardStackLength--
                }
            }
        }
    }

    property int forwardStackLength: 0
    property var forwardStack: []

    PageLoadDialog {
        id: pageLoadDialog
        anchors.centerIn: parent
        width: Math.min(400, parent.width - pagerFrame.height)
        height: parent.height - 2 * pagerFrame.height

        onLoadRadixView: {
        }
        onLoadDocView: {
            var screenComponent = Qt.createComponent(viewName)
            var screen = screenComponent.createObject(browserScreen)
            for (var s = 0; s < forwardStack.length; ++s)
            {
                forwardStack[s].destroy()
            }
            forwardStack = []
            forwardStackLength = 0
            browserStack.push(screen)
        }
    }

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

    property alias radixHora: radixScreen.hora

    StackView {
        id: browserStack
        anchors.fill: parent
        initialItem: RadixScreen {
            id: radixScreen
        }
    }
}
