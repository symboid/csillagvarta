
//pragma Singleton
import QtQuick 2.6
import QtQuick.Controls 2.2
import Symboid.Sdk.App 1.0
import Symboid.Sdk.Dox 1.0
import Symboid.Astro.Calculo 1.0

Item {
    id: views

    property Document mainDoc: null
    property int viewIndex: -1

    function docViewComponent(docViewType) {
        switch (docViewType)
        {
        case "radix": return radixViewComponent
        case "solar": return solarViewComponent
        case "lunar": return lunarViewComponent
        default:      return emptyViewComponent
        }
    }

    Component {
        id: emptyViewComponent
        DocInputView {
        }
    }

    Component {
        id: radixViewComponent
        RadixInputView {
            mainDoc: views.mainDoc
            viewIndex: views.viewIndex
        }
    }

    Component {
        id: solarViewComponent
        SolarInputView {
            mainDoc: views.mainDoc
            viewIndex: views.viewIndex
        }
    }

    Component {
        id: lunarViewComponent
        LunarInputView {
            mainDoc: views.mainDoc
            viewIndex: views.viewIndex
        }
    }
}
