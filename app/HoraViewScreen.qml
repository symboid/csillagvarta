
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

    property string houseType: ""

    property alias autocalc: horaPanel.autocalc

    function setCurrent()
    {
        dateTimeParams.setCurrent()
    }

    property HoraCoords horaCoords: HoraCoords {
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
    property Hora hora: Hora {
        coords: horaCoords
    }

    property alias dateTimeEditable: dateTimeParams.editable
    property alias dateTimeVisible: dateTimeParams.visible

    property alias multiDataModel: multiDataView.dataViewModel

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
            id: multiDataView
            vertical: metrics.isLandscape
            width: metrics.isTransLandscape ? horzMandalaSpace : mandalaSize
            height: mandalaSize
            dataViewModel: ObjectModel {
                HoraPanel {
                    id: horaPanel
                    isLandscape: metrics.isLandscape
                    withSeparator: true
                    horaView: SingleHoraView {
                        hora: horaViewScreen.hora
                        housesType: houseType
                    }
                }
            }
        }

        MainScreenLocationBox {
            id: locationParams
            showDetails: horaViewScreen.showDetails
        }

    }

    property alias dataViews: additionalViews.model
    Repeater {
        id: additionalViews
        onItemAdded: multiDataModel.insert(1 + index, item)
    }

    property alias rightElements: rightDocItems.model
    Repeater {
        id: rightDocItems
        onItemAdded: docViewModel.append(item)
    }
}
