
import QtQuick 2.12
import QtQuick.Controls 2.5
import Symboid.Sdk.Controls 1.0
import Symboid.Astro.Controls 1.0
import Symboid.Astro.Db 1.0
import Symboid.Astro.Hora 1.0
import QtQuick.Layouts 1.12
import QtQml.Models 2.12

DocViewScreen {
    id: horaViewScreen

    property alias showCurrent: dateTimeParams.showCurrentTimer
    property alias autocalc: horaPanel.autocalc

    property alias horaYear: dateTimeParams.year
    property alias horaMonth: dateTimeParams.month
    property alias horaDay: dateTimeParams.day
    property alias horaHour: dateTimeParams.hour
    property alias horaMinute: dateTimeParams.minute
    property alias horaSecond: dateTimeParams.second
    property alias horaCalendarType: calendarType.currentIndex

    property alias horaGeoName: locationParams.geoName
    property alias horaGeoLatt: locationParams.geoLatt
    property alias horaGeoLont: locationParams.geoLont
    property alias horaGeoTzDiff: locationParams.geoTzDiff

    function setCurrent()
    {
        dateTimeParams.setCurrent()
    }

    property Hora mainHora: Hora {
        coords: HoraCoords {
            year: dateTimeParams.year
            month: dateTimeParams.month
            day: dateTimeParams.day
            hour: dateTimeParams.hour
            minute: dateTimeParams.minute
            second: dateTimeParams.second

            geoLatt: locationParams.geoLatt
            geoLont: locationParams.geoLont
            tzDiff: locationParams.geoTzDiff

            withJulianCalendar: calendarType.currentIndex !== 0
        }
    }

    docViewModel: ObjectModel {

        MainScreenDateTimeBox {
            id: dateTimeParams
            showSeconds: showDetails
            popupParent: parent
        }

        MainScreenComboBox {
            id: calendarType
            title: qsTr("Calendar")
            visible: showDetails
            model: [ qsTr("Gregorian"), qsTr("Julian") ]
        }

        MultiDataView {
            vertical: metrics.isLandscape
            width: metrics.isTransLandscape ? horzMandalaSpace : mandalaSize
            height: mandalaSize
            Page {
                HoraPanel {
                    id: horaPanel
                    anchors.fill: parent
                    isLandscape: metrics.isLandscape
                    withSeparator: true
                    hora: mainHora

                    housesType: housesType.currentToken()
                }
            }
            Page {
                PlanetsTableView {
                    id: planetTableView
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: showPlanetSeconds.top

                    tableModel: horaPanel.planetsModel
                    showSeconds: showPlanetSeconds.checked
                }
                CheckBox {
                    id: showPlanetSeconds
                    anchors {
                        horizontalCenter: parent.horizontalCenter
                        bottom: parent.bottom
                        bottomMargin: 20
                    }
                    text: qsTr("Show seconds")
                    onCheckedChanged: {
                        planetTableView.tableModel.update()
                    }
                }
            }
            Page {
                HousesTableView {
                    id: houseTableView
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: showHousesSeconds.top

                    tableModel: horaPanel.housesModel
                    showSeconds: showHousesSeconds.checked
                }
                CheckBox {
                    id: showHousesSeconds
                    anchors {
                        horizontalCenter: parent.horizontalCenter
                        bottom: parent.bottom
                        bottomMargin: 20
                    }
                    text: qsTr("Show seconds")
                    onCheckedChanged: {
                        houseTableView.tableModel.update()
                    }
                }
            }
        }

        MainScreenLocationBox {
            id: locationParams
            showDetails: horaViewScreen.showDetails
        }

        MainScreenComboBox {
            id: housesType
            title: qsTr("House system")
            visible: showDetails
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
