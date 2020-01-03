
import QtQuick 2.12
import QtQuick.Controls 2.5
import Symboid.Astro.Eph 1.0
import Symboid.Astro.Calculo 1.0

Flickable {

    property bool showDetails: false
    property int mandalaSize: 0
    property int screenSize: 0
    property int restSize: screenSize - mandalaSize
    property bool isLandscape: true

    flickableDirection: isLandscape ? Flickable.HorizontalFlick : Flickable.VerticalFlick
    contentWidth: horaScreen.width
    contentHeight: horaScreen.height

    Flow {
        id: horaScreen

        width: isLandscape ? childrenRect.width : mandalaSize
        height: isLandscape ? mandalaSize : childrenRect.height

        readonly property int minParamSectionWidth: 300
        readonly property int paramSectionWidth:
            isLandscape ? ((restSize / 2) < minParamSectionWidth ? minParamSectionWidth : restSize / 2)
                        : ((mandalaSize / 2) < minParamSectionWidth ? mandalaSize : mandalaSize / 2)

        flow: isLandscape ? Flow.TopToBottom : Flow.LeftToRight

        HoraScreenParams {
            title: qsTr("Horoscope name")
            TextField {
                id: radixName
                width: parent.defaultItemWidth
                leftPadding: 10
                rightPadding: leftPadding
                placeholderText: qsTr("name")
            }
        }

        HoraScreenParams {
            title: qsTr("Date and time")

            DateCoordBox {
                id: dateBox
                editable: true
            }
            TimeCoordBox {
                id: timeBox
                editable: true
                circularLink: dateBox.dayLink
            }
        }

        HoraScreenParams {
            title: qsTr("Calendar")
            visible: showDetails
            ComboBox {
                width: parent.defaultItemWidth
                model: [ "Gregorian", "Julian" ]
            }
        }

        HoraView {
            id: horaView
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

        HoraScreenParams {
            title: qsTr("Location")

            Row {
                TextField {
                    width: parent.parent.defaultItemWidth - parent.spacing - locationButton.width
                }
                spacing: 10
                Button {
                    id: locationButton
                    height: parent.height
                    width: height
                    text: "..."
                }
            }
            GeoCoordBox {
                id: geoLatt
                visible: showDetails
                isLattitude: true
                editable: true
            }
            GeoCoordBox {
                id: geoLont
                visible: showDetails
                editable: true
            }

            Row {
                visible: showDetails
                Label {
                    width: parent.parent.defaultItemWidth - parent.spacing - tzDiff.width
                    anchors.verticalCenter: parent.verticalCenter
                    text: qsTr("Time zone diff:")
                }
                MultiNumberBox {
                    id: tzDiff
                    editable: true
                    property int hour: numberBox(0).value
                    boxes: ListModel {
                        ListElement {
                            number_from: -12
                            number_to: 12
                            number_suffix: qsTr("h")
                        }
                    }
                }
            }

        }
        HoraScreenParams {
            title: qsTr("House system")
            visible: showDetails

            ComboBox {
                width: parent.defaultItemWidth
                model: [ "Placidus", "Mundan" ]
            }
        }
    }
}
