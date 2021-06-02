
import QtQuick 2.12
import QtQuick.Controls 2.5
import Symboid.Sdk.Controls 1.0
import Symboid.Astro.Hora 1.0
import QtQml.Models 2.12

HoraViewScreen {
    id: radixScreen
    property alias autocalc: horaPanel.autocalc

    showCurrent: showDetails
    houseType: housesType.currentToken()

    signal saveDocument(string radixTitle)
    horaButton: RoundButton {
        radius: 5
        enabled: horaTitle !== ""
        display: RoundButton.IconOnly
        icon.source: "/icons/save_icon&32.png"
        icon.color: "#C94848"
        onClicked: saveDocument(horaTitle)
    }
    dataViewModel: ObjectModel {
        Page {
            HoraPanel {
                id: horaPanel
                anchors.fill: parent
                isLandscape: metrics.isLandscape
                withSeparator: true
                hora: radixScreen.hora

                housesType: houseType
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

    rightDocModel: ObjectModel {
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
