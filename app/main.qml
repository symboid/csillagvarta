import QtQuick 2.12
import QtQuick.Controls 2.5
import Symboid.Astro.Eph 1.0
import Symboid.Astro.Calculo 1.0

ApplicationWindow {
    visible: true

    x:0
    y:0
    width: screen.desktopAvailableWidth
    height: screen.desktopAvailableHeight
    readonly property bool isLandscape: width > height
    readonly property int paramsColumnWidth:
        isLandscape ? (width - horaView.width) / 2// - params.padding - params.spacing
                    : width / 2// - params.padding

    Flow {
        id: params
        anchors.fill: parent
        flow: isLandscape ? Flow.TopToBottom : Flow.LeftToRight

        HoraParamColumn {
            title: qsTr("Horoscope name")
            width: paramsColumnWidth
            TextField {
                id: radixName
                width: 200
                anchors.right: parent.right
                anchors.rightMargin: 60
                leftPadding: 10
                rightPadding: leftPadding
                placeholderText: qsTr("name")
            }
        }

        HoraParamColumn {
            title: qsTr("Date and time")
            width: paramsColumnWidth

            DateCoordBox {
                id: dateBox
                anchors.right: parent.right
                editable: true
            }
            TimeCoordBox {
                id: timeBox
                anchors.right: parent.right
                editable: true
                showSeconds: false
                circularLink: dateBox.dayLink
            }
        }

        HoraParamColumn {
            title: qsTr("Calendar")
            width: paramsColumnWidth
            visible: details.checked
            ComboBox {
                width: 200
                anchors.right: parent.right
                model: [ "Gregorian", "Julian" ]
            }
/*            RadioButton {
                anchors.left: parent.left
                anchors.leftMargin: 24
                text: qsTr("Gregorian")
                checked: true
            }
            RadioButton {
                anchors.left: parent.left
                anchors.leftMargin: 24
                text: qsTr("Julian")
            }*/
        }

        HoraView {
            id: horaView
            property int mandalaSize: isLandscape ? parent.height : parent.width
            width: mandalaSize
            height: mandalaSize

            year: dateBox.year
            month: dateBox.month
            day: dateBox.day
            hour: timeBox.hour
            minute: timeBox.minute
            second: timeBox.second
            geoLatt: geoLatt.arcDegree
            geoLont: geoLont.arcDegree
            tzDiff: 0
        }

        HoraParamColumn {
            title: qsTr("Location")
            width: paramsColumnWidth

            Row {
                anchors.right: parent.right
                TextField {
                    id: locationName
                    width: 200
                }
                Item { width:10; height:1 }
                RoundButton {
                    height: locationName.height
                    width: height * 2
                    text: "..."
                }
            }
            GeoCoordBox {
                id: geoLatt
                anchors.right: parent.right
                visible: details.checked
                isLattitude: true
                editable: true
            }
            GeoCoordBox {
                id: geoLont
                anchors.right: parent.right
                visible: details.checked
                editable: true
            }
            Row {
                anchors.right: parent.right
                visible: details.checked
                Label {
                    anchors.verticalCenter: parent.verticalCenter
                    text: qsTr("Time zone diff:")
                }
                NumberBox {
                    from: -12
                    to: 12
                    editable: true
                }
            }
        }
        HoraParamColumn {
            title: qsTr("House system")
            width: paramsColumnWidth
            visible: details.checked

            ComboBox {
                width: 200
                anchors.right: parent.right
                model: [ "Placidus", "Mundan" ]
            }
        }
    }
    Switch {
        id: details
        anchors {
            bottom: parent.bottom
            bottomMargin: 20
            right: parent.right
            rightMargin: 20
        }
        text: qsTr("Details")
    }
}
