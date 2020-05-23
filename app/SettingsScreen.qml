
import QtQuick 2.12
import QtQuick.Controls 2.5
import Symboid.Sdk.Controls 1.0 as UiControls
import Symboid.Astro.Controls 1.0

UiControls.SettingsScreen {

    UiControls.SettingsPane {
        title: qsTr("General")

        UiControls.UiStyleSettingsGroup {

        }
    }

    HoraSettingsPane {

    }

    OrbisSettingsPane {

    }

    UiControls.SoftwarePane {

    }

}
