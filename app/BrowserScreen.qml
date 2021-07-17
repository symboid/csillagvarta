
import QtQuick 2.12
import QtQuick.Controls 2.5
import Symboid.Sdk.Controls 1.0
import Symboid.Sdk.Dox 1.0
import Symboid.Astro.Hora 1.0

Page {

    property Component buttonRow: Component {
        Row {
            ToolButton {
                icon.source: "/icons/br_prev_icon&32.png"
                width: 80
                enabled: documentsBrowser.docPageIndex > 0
                onClicked: documentsBrowser.backward()
            }
            ToolButton {
                icon.source: "/icons/calc_icon&32.png"
                width: 80
                highlighted: true
                onClicked: documentsBrowser.pageLoadDialogOpen()
            }
            ToolButton {
                icon.source: "/icons/br_next_icon&32.png"
                width: 80
                enabled: documentsBrowser.docPageIndex < documentsBrowser.docPageCount - 1
                onClicked: documentsBrowser.forward()
            }
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

    property alias radixCoords: radixScreen.horaCoords
    property alias radixHora: radixScreen.hora

    DocumentsBrowser {
        id: documentsBrowser
        anchors.fill: parent
        radixScreen: RadixScreen {
            id: radixScreen
        }
    }

    property Popup loadingPopup: Popup {
        anchors.centerIn: parent
        height: pageTitle.height * 2
        width: Math.min(pageTitle.width * 3, parent.width - 50)
        onOpened: loadingTimer.start()
        Timer {
            id: loadingTimer
            interval: 700
            onTriggered: loadingPopup.close()
        }
        Label {
            id: pageTitle
            anchors.centerIn: parent
            font.italic: true
        }
        function show(title)
        {
            pageTitle.text = title
            open()
        }
    }
}
