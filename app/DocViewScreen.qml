
import QtQuick 2.12
import QtQuick.Controls 2.5
import Symboid.Sdk.Controls 1.0
import Symboid.Sdk.Dox 1.0
import Symboid.Astro.Hora 1.0
import QtQml.Models 2.12

DocPage {

    docTitle: horaName.text
    property alias horaTitle: horaName.text
    property alias horaButton: horaName.button
    property alias showDetails: details.checked

    property alias showRadixSelector: radixSelector.visible
    property Hora radixHora: radixSelector.currentValue

    screenModel: ObjectModel {
        MainScreenParamBox {
            title: qsTr("Horoscope name")
            MainScreenTextField {
                id: horaName
                placeholderText: qsTr("Enter a name!")
            }
        }
        MainScreenComboBox {
            id: radixSelector
            title: qsTr("Radix")
            visible: showDetails
            textRole: "radixTitle"
            valueRole: "radixHora"
            model: radixModel
        }
        Item {
            id: detailsHelper
            width:1; height:1
        }
        MainScreenDetailsSwitch {
            id: details
            referenceItem: detailsHelper
        }
    }

    property alias docViewModel: docViewItems.model
    Repeater {
        id: docViewItems
        onItemAdded: screenModel.insert(2 + index, item)
    }
}
