
import QtQuick 2.12
import QtQuick.Controls 2.5
import Symboid.Sdk.Controls 1.0
import Symboid.Sdk.Dox 1.0
import Symboid.Astro.Hora 1.0
import QtQml.Models 2.12

HoraViewScreen {
    id: radixScreen

    showCurrent: showDetails
    showRadixSelector: false
    houseType: housesType.currentToken()

    Rectangle {
        anchors.fill: parent
        anchors.margins: 2
        color: "transparent"
        border.color: "darkgray"
        border.width: 2
    }

    property Document mainDocument: Document {
        title: radixScreen.pageTitle
        onTitleChanged: {
            radixScreen.pageTitle = title
            title = Qt.binding(function(){return radixScreen.pageTitle})
        }
        onLoadStarted: radixScreen.autocalc = false
        onLoadFinished: radixScreen.autocalc = true
        onLoadFailed: radixScreen.autocalc = true

        DocumentNode {
            name: "radix"

            property alias title: radixScreen.pageTitle

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

    dataViews: ObjectModel {
        Page {
            PlanetsTableView {
                id: planetTableView
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: showPlanetSeconds.top

                tableModel: HoraPlanetsModel {
                    hora: radixScreen.hora
                }

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
                onCheckedChanged: planetTableView.refresh()
            }
        }
        Page {
            HousesTableView {
                id: houseTableView
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: showHousesSeconds.top

                tableModel: HoraHousesModel {
                    hora: radixScreen.hora
                }

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
                    houseTableView.refresh()
//                    houseTableView.tableModel.update()
                }
            }
        }
    }

    rightElements: ObjectModel {
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

    Component.onCompleted: {
        setCurrent()
        autocalc = true
    }
}
