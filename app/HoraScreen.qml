
import QtQuick 2.12
import QtQuick.Controls 2.5
import Symboid.Sdk.Controls 1.0
import Symboid.Astro.Controls 1.0
import QtPositioning 5.12

Flickable {

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
            visible: details.checked
            ComboBox {
                id: calendarType
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
            tzDiff: tzDiff.hour
            housesType: housesType.currentToken()
            withJulianCalendar: calendarType.currentIndex !== 0

            Switch {
                id: details
                anchors {
                    bottom: parent.bottom
                    right: parent.right
                }
                text: qsTr("Details")
            }

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
                visible: details.checked
                isLattitude: true
                editable: true
                enabled: !positionSrc.active || !positionSrc.valid
            }
            GeoCoordBox {
                id: geoLont
                visible: details.checked
                editable: true
                enabled: !positionSrc.active || !positionSrc.valid
            }

            Row {
                visible: details.checked
                spacing: 10
                Label {
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

            PositionSource {
                id: positionSrc
                updateInterval: 1000
                active: currLocSwitch.checked
                onPositionChanged: {
                    if (valid)
                    {
                        if (position.latitudeValid)
                        {
                            geoLatt.setArcDegree(position.coordinate.latitude)
                        }
                        if (position.longitudeValid)
                        {
                            geoLont.setArcDegree(position.coordinate.longitude)
                        }
                    }
                }
                onSourceErrorChanged: {
                    if (sourceError !== PositionSource.NoError)
                    {
                        currLocSwitch.toggle()
                    }
                }

            }
            Switch {
                id: currLocSwitch
                text: qsTr("Use current")
                visible: details.checked
                enabled: positionSrc.supportedPositioningMethods & PositionSource.SatellitePositioningMethods
            }
        }
        HoraScreenParams {
            title: qsTr("House system")
            visible: details.checked

            ComboBox {
                id: housesType
                width: parent.defaultItemWidth
                textRole: "name"
                model: ListModel {
                    ListElement {
                        name: qsTr("Placidus")
                        token: "placidus"
                    }
                    ListElement {
                        name: qsTr("Koch")
                        token: "koch"
                    }
                    ListElement {
                        name: qsTr("Regiomontanus")
                        token: "regiomontanus"
                    }
                    ListElement {
                        name: qsTr("Campanus")
                        token: "campanus"
                    }
                    ListElement {
                        name: qsTr("Equal")
                        token: "equal"
                    }
                }
                function currentToken()
                {
                    return model.data(model.index(currentIndex, 0))
                }
            }
        }
    }
}
