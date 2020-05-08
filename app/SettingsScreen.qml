
import QtQuick 2.12
import QtQuick.Controls 2.5
import Symboid.Sdk.Controls 1.0 as UiControls

UiControls.SettingsScreen {
    UiControls.SettingsPane {
        title: qsTr("General")
        UiControls.SettingsGroup {
            id: swUpdateGroup
            title: qsTr("Software update")
            Grid {
                columns: 2
                rowSpacing: 10
                columnSpacing: 10
                readonly property int textWidth: parent.width - automatedSwUpdate.width - columnSpacing
                RadioButton {
                    id: automatedSwUpdate
                    text: qsTr("Automated")
                    font.bold: true
                }
                Text {
                    width: parent.textWidth
                    text: qsTr("Download and integration of new software revision will be performed automatically. New features will be available after application relaunch.")
                    wrapMode: Text.WordWrap
                }
                RadioButton {
                    id: swUpdateOff
                    text: qsTr("Switched off")
                    font.bold: true
                }
                Text {
                    width: parent.textWidth
                    text: qsTr("No software updates will be executed at all. No new features and bugfixes are available.")
                    wrapMode: Text.WordWrap
                }
            }
        }
        UiControls.SettingsGroup {
            title: qsTr("House cusps")
            Rectangle {
                width: parent.width
                height: 100
                border.color: "blue"
            }
        }
        UiControls.SettingsGroup {
            title: qsTr("Xxxx")
            Rectangle {
                width: parent.width
                height: 100
                border.color: "green"
            }
        }
    }
    UiControls.SettingsPane {
        title: qsTr("Orbis")
/*        Rectangle {
            border.width: 3
            border.color: "red"
//            anchors.centerIn: parent
            width: 200
            height: 200
        }
        */
    }
}
