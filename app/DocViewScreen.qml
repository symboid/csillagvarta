
import QtQuick 2.12
import QtQuick.Controls 2.5
import Symboid.Sdk.Controls 1.0

MainScreen {

    readonly property int mandalaSize: metrics.isLandscape ? metrics.screenHeight : metrics.screenWidth
    readonly property int restSize: metrics.screenSize - mandalaSize
    readonly property int horzMandalaSpace: metrics.screenWidth - 2 * metrics.minParamSectionWidth

    metrics.isTransLandscape: metrics.isLandscape && horzMandalaSpace < mandalaSize
    metrics.paramSectionWidth:
        metrics.isLandscape ? ((restSize / 2) < metrics.minParamSectionWidth ? metrics.minParamSectionWidth : restSize / 2)
                    : ((mandalaSize / 2) < metrics.minParamSectionWidth ? mandalaSize : mandalaSize / 2)

}
