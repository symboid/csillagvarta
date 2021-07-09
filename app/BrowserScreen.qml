
import QtQuick 2.12
import QtQuick.Controls 2.5
import Symboid.Sdk.Controls 1.0
import Symboid.Sdk.Dox 1.0
import Symboid.Astro.Hora 1.0

Page {
    id: browserScreen

    header: ToolBar {
        Row {
            anchors.horizontalCenter: parent.horizontalCenter

            ToolButton {
                icon.source: "/icons/br_prev_icon&32.png"
                enabled: browserStack.depth > 1
                onClicked: forwardStack.push(browserStack.pop())
            }
            ToolButton {
                icon.source: "/icons/target_icon&32.png"
                enabled: browserStack.depth > 1
                onClicked: browserStack.home()
            }
            ToolButton {
                icon.source: "/icons/calc_icon&32.png"
                onClicked: pageLoadDialog.open()
            }
            ToolButton {
                icon.source: "/icons/doc_lines_icon&32.png"
                enabled: false
            }
            ToolButton {
                icon.source: "/icons/br_next_icon&32.png"
                enabled: forwardStack.length > 0
                onClicked: browserStack.push(forwardStack.pop())
            }
        }
    }

    PageLoadDialog {
        id: pageLoadDialog
        anchors.centerIn: parent
        width: Math.min(400, parent.width - header.height)
        height: parent.height - 2 * header.height

        onLoadRadixView: browserStack.home()
        onLoadDocView: {
            var screenComponent = Qt.createComponent(viewName)
            var screen = screenComponent.createObject(browserScreen)
            browserStack.push(screen)
            forwardStack.cleanup()
        }
    }

    StackObject {
        id: forwardStack
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

    property alias radixCoords: radixScreen.horaCoords
    property alias radixHora: radixScreen.hora

    StackView {
        id: browserStack
        anchors.fill: parent
        initialItem: RadixScreen {
            id: radixScreen
        }
        pushEnter: null
        pushExit: null
        popEnter: null
        popExit: null
        function home()
        {
            while (depth > 1)
            {
                forwardStack.push(browserStack.pop())
            }
        }
    }
}
