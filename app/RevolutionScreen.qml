
import QtQuick 2.12
import QtQuick.Controls 2.5
import Symboid.Sdk.Controls 1.0
import Symboid.Astro.Controls 1.0
import Symboid.Astro.Hora 1.0
import QtQml.Models 2.12

SynastryScreen {

    dateTimeEditable: false
    dateTimeVisible: showDetails

    auxParams: ObjectModel {

        MainScreenParamBox {
            title: qsTr("Revolution parameters")
            Pane {
                id: revolutingPlanetPane
                Row {
                    spacing: revolutingPlanetPane.padding
                    Label {
                        anchors.verticalCenter: parent.verticalCenter
                        text: qsTr("Planet:")
                    }
                    ComboBox {
                        id: revolutingPlanet
                        anchors.verticalCenter: parent.verticalCenter
                        model: revolutions.planetModel
                        currentIndex: 0
                    }
                }
            }
            Pane {
                visible: showDetails
                Row {
                    spacing: revolutingPlanetPane.padding
                    Label {
                        anchors.verticalCenter: parent.verticalCenter
                        text: qsTr("Ecl. position:")
                    }

                    ArcCoordLabel {
                        arcDegree: revolutions.planetLont
                        sectionCalc: ZodiacSectionCalc {}
                        sectionFont.family: "Symboid"
                    }
                }
            }
            Row {
                id: yearParamRow
                spacing: revolutingPlanetPane.padding
                Label {
                    anchors.verticalCenter: parent.verticalCenter
                    text: qsTr("Year:")
                }

                MultiNumberBox {
                    id: startYear
                    editable: true
                    boxes: Row {
                        NumberBox {
                            from: radixCoords.year
                            to: radixCoords.year + 100
                            displaySuffix: "."
                        }
                    }
                }
            }
            Row {
                id: countParamRow
                visible: showDetails
                spacing: revolutingPlanetPane.padding
                Label {
                    anchors.verticalCenter: parent.verticalCenter
                    text: qsTr("Number of revolutions:")
                }

                MultiNumberBox {
                    id: revCount
                    editable: true
                    boxes: Row {
                        NumberBox {
                            from: 1
                            to: 100
                        }
                    }
                }
            }
        }

        RevolutionParamsPane {
            id: revolutions
            planetIndex: revolutingPlanet.currentIndex
            hora: radixHora
            onDefaultRevCountChanged: revCount.box(0).value = defaultRevCount
            year: startYear.box(0).value
            revCount: revCount.box(0).value
            tzDiff: horaGeoTzDiff

            onRevCoordsChanged: {
                if (revCoords !== undefined)
                {
                    horaYear = revCoords.year
                    horaMonth = revCoords.month
                    horaDay = revCoords.day
                    horaHour = revCoords.hour
                    horaMinute = revCoords.minute
                    horaSecond = revCoords.second
                    horaCalendarType = revCoords.withJulianCalendar ? 1 : 0
                }
            }
        }
    }

    Component.onCompleted: {
        docViewModel.remove(3)
    }
}
