
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
