
import QtQuick 2.12
import QtQuick.Controls 2.5
import Symboid.Sdk.Controls 1.0
import Symboid.Sdk.Hosting 1.0 as Hosting
import Symboid.Sdk.Hosting 1.0
import Symboid.Astro.Hora 1.0

Hosting.SettingsScreen {

    FolderGroupFixed {
        title: qsTr("General")

        AppearanceSettingsGroup {

        }
    }

    HoraSettingsPane {

    }

    SoftwarePane {

    }

}
