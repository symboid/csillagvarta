
import QtQuick 2.12
import QtQuick.Controls 2.5
import Symboid.Sdk.Controls 1.0
import Symboid.Astro.Hora 1.0
import QtQml.Models 2.12

SynastryScreen {

    dateTimeEditable: false
    dateTimeVisible: showDetails

    auxParams: ObjectModel {
        MainScreenComboBox {
            id: revolutionPlanet
            title: qsTr("Planet")
            model: [ qsTr("Sun"), qsTr("Moon") ]
        }
        MainScreenParamBox {
            id: revolutionParams
            title: qsTr("Revolution")
            Row {
                id: yearParamRow
                spacing: 10
                Label {
                    anchors.verticalCenter: parent.verticalCenter
                    text: qsTr("Year:")
                }

                MultiNumberBox {
                    editable: true
                    boxes: Row {
                        NumberBox {
                            from: radixHora.coords.year
                            to: radixHora.coords.year + 100
                            displaySuffix: "."
                        }
                    }
                }
            }
            Pane {
                width: yearParamRow.width + padding
                ComboBox {
                    id: comboBox
                    anchors.fill: parent
                }
            }
        }
    }

    Component.onCompleted: {
        docViewModel.remove(3)
    }
}
