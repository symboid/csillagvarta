
import QtQuick 2.12
import QtQuick.Controls 2.5
import Symboid.Sdk.Controls 1.0
import Symboid.Astro.Hora 1.0
import QtQml.Models 2.12

HoraViewScreen {
    id: synastryScreen

    property alias auxParams: auxParamItems.model
    Repeater {
        id: auxParamItems
        onItemAdded: docViewModel.insert(index, item)
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
                    hora: synastryScreen.hora
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
                onCheckedChanged: {
                    planetTableView.tableModel.update()
                }
            }
        }
        HoraPanel {
            id: horaPanel
            isLandscape: metrics.isLandscape
            withSeparator: true
            horaView: DoubleHoraView {
                mainHora: radixHora
                auxHora: synastryScreen.hora
                housesType: houseType
            }
        }
    }

    Component.onCompleted: {
        setCurrent()
        autocalc = true
    }
}
