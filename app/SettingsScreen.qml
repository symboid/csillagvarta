
import QtQuick 2.12
import QtQuick.Controls 2.5
import Symboid.Sdk.Hosting 1.0 as Hosting
import Symboid.Sdk.Hosting 1.0
import Symboid.Astro.Hora 1.0

Hosting.SettingsScreen {

    SettingsPane {
        title: qsTr("General")

        UiStyleSettingsGroup {

        }
    }

    HoraSettingsPane {

    }

    OrbisSettingsPane {

    }

    SoftwarePane {

    }

}
