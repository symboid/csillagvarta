
import QtQuick 2.12
import QtQuick.Controls 2.5
import Symboid.Sdk.Controls 1.0
import Symboid.Sdk.Controls 1.0 as Sdk
import Symboid.Sdk.Dox 1.0
import Symboid.Astro.Controls 1.0
import Symboid.Astro.Db 1.0
import Symboid.Astro.Hora 1.0
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.3

Sdk.MainScreen {

    function setCurrent()
    {
        dateTimeParams.currentTimerOn = true
        locationParams.lockedToCurrent = true
    }
    function unsetCurrent()
    {
        dateTimeParams.currentTimerOn = false
        locationParams.lockedToCurrent = false
    }

    MainScreenParamBox {
        title: qsTr("Horoscope name")
        MainScreenTextField {
            id: horaName
        }
    }

    MainScreenDateTimeBox {
        id: dateTimeParams
        showCurrentTimer: details.checked
    }

    MainScreenParamBox {
        id: calendarParam
        title: qsTr("Calendar")
        visible: details.checked
        MainScreenComboBox {
            id: calendarType
            model: [ "Gregorian", "Julian" ]
        }
    }

    MainScreenViewSelector {
        id: viewSelector
        viewNames: [ qsTr("Chart"), qsTr("Planet positions"), qsTr("House cusps") ]
        referenceItem: details.checked ? calendarParam : dateTimeParams
    }

    StackLayout {
        width: metrics.mandalaSize
        height: metrics.mandalaSize
        currentIndex: viewSelector.currentIndex
        HoraPanel {
            id: horaPanel
            isLandscape: metrics.isLandscape
            minHoraSize: metrics.mandalaSize
            horaSize: metrics.mandalaSize

            year: dateTimeParams.year
            month: dateTimeParams.month
            day: dateTimeParams.day
            hour: dateTimeParams.hour
            minute: dateTimeParams.minute
            second: dateTimeParams.second

            geoLatt: locationParams.geoLatt
            geoLont: locationParams.geoLont
            tzDiff: locationParams.geoTzDiff

            displayFlags: HoraView.SHOW_FIXSTARS
            housesType: housesType.currentToken()
            withJulianCalendar: calendarType.currentIndex !== 0
        }
        Item {
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
        Item {
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
        showDetails: details.checked
    }

    MainScreenParamBox {
        id: houseSystemParams
        title: qsTr("House system")
        visible: details.checked

        MainScreenComboBox {
            id: housesType
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

    MainScreenDetailsSwitch {
        id: details
        referenceItem: checked ? houseSystemParams : locationParams
    }

    Document {
        id: horaDocument
        title: horaName.text

        DocumentNode {
            name: "radix"

            property alias title: horaName.text

            DocumentNode {
                name: "time"
                property alias year: dateTimeParams.year
                property alias month: dateTimeParams.month
                property alias day: dateTimeParams.day
                property alias hour: dateTimeParams.hour
                property alias minute: dateTimeParams.minute
                property alias second: dateTimeParams.second
                property alias calendarType: calendarType.currentIndex
            }
            DocumentNode {
                name: "geoLoc"
                property alias geoName: locationParams.geoName
                property alias latt: locationParams.geoLatt
                property alias lont: locationParams.geoLont
                property alias tzDiff: locationParams.geoTzDiff
            }
        }
        onLoadStarted: {
            unsetCurrent()
        }

        onLoadCurrent: {
            horaName.text = qsTr("Current Transit")
            setCurrent()
        }
    }

    toolButtons: ListModel {
        ListElement {
            toolIcon: "/icons/doc_lines_icon&32.png"
            toolOperation: function() { horaDocumentDialog.open() }
        }
        ListElement {
            toolIcon: "/icons/zoom_icon&32.png"
            toolOperation: function() { horaPanel.zoomToDefault() }
        }
        ListElement {
            toolIcon: "/icons/cog_icon&32.png"
            toolOperation: function() { mainWindow.settingsClicked() }
        }
    }

    HoraDocumentDialog {
        id: horaDocumentDialog
        currentDocument: horaDocument
        Material.background: "#DFEEE5"
        opacity: 0.875
    }

    Component.onCompleted: {
        dateTimeParams.setCurrent()
        horaPanel.interactive = true
    }
}
