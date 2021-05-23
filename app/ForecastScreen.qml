
import QtQuick 2.12
import QtQuick.Controls 2.5
import Symboid.Sdk.Controls 1.0
import Symboid.Astro.Controls 1.0
import Symboid.Astro.Hora 1.0

DocViewScreen {

    property Hora radixHora: null
    property HoraCoords radixCoords: radixHora.coords

    MainScreenComboBox {
        id: forecastType
        title: qsTr("Forecast type")
        model: [
            qsTr("Primary direction"),
            qsTr("Secondary direction"),
            qsTr("Transit")
        ]
        onCurrentIndexChanged: {
            switch (currentIndex)
            {
            case 0: forecastTablePane.forecastModel = ForecastItemModel.PRI_DIREX; break
            case 1: forecastTablePane.forecastModel = ForecastItemModel.SEC_DIREX; break
            case 2: forecastTablePane.forecastModel = ForecastItemModel.TRANSIT; break
            default: forecastTablePane.forecastModel = ForecastItemModel.PRI_DIREX; break
            }
        }
    }

    DirexModel {
        id: direxModel
    }

    TransitModel {
        id: transitModel
    }

    MainScreenParamBox {
        id: periodParam
        title: qsTr("Period")
        DateCoordBox {
            id: periodBeginDate
            editable: true
        }
        DateCoordBox {
            id: periodEndDate
            editable: true
        }
    }

    MultiDataView {
        width: metrics.isTransLandscape ? horzMandalaSpace : mandalaSize
        height: mandalaSize
        Page {
            ForecastTablePane {
                id: forecastTablePane
                anchors.fill: parent
                hora: radixHora
                periodBegin: HoraCoords {
                    year: periodBeginDate.year
                    month: periodBeginDate.month
                    day: periodBeginDate.day
                }
                periodEnd: HoraCoords {
                    year: periodEndDate.year
                    month: periodEndDate.month
                    day: periodEndDate.day
                }
            }
        }
    }

    MainScreenParamBox {
        title: qsTr("Radix date and time")
        Pane {
            Label {
                text: (new Date(radixCoords.dateTime)).toLocaleDateString()
            }
        }
        Pane {
            Label {
                text: Qt.formatTime(radixCoords.dateTime)
            }
        }
    }

    MainScreenParamBox {
        title: qsTr("Radix positioning")
        Repeater {
            model: ListModel {
                ListElement {
                    titleText: qsTr("Minutes")
                }
                ListElement {
                    titleText: qsTr("Hours")
                }
                ListElement {
                    titleText: qsTr("Days")
                }
            }

            delegate: Pane {
                Row {
                    RoundButton {
                        radius: 0
                        icon.source: "/icons/playback_prev_icon&24.png"
                    }
                    Label {
                        anchors.verticalCenter: parent.verticalCenter
                        text: titleText
                        width: 100
                        horizontalAlignment: Label.AlignHCenter
                    }
                    RoundButton {
                        radius: 0
                        icon.source: "/icons/playback_next_icon&24.png"
                    }
                }
            }
        }
    }
}
