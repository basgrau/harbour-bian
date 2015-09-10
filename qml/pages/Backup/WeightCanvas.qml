import QtQuick 2.0
import Sailfish.Silica 1.0
import "CanvasModule.js" as CanvasModule
import QtQuick.LocalStorage 2.0
import "DBModule.js" as DBModule

Canvas {
    width: 240
    id: weightCanvas
    height: 240
    onPaint: {
        var wL = DBModule.DBModule.getLastWeight()
        var wB = DBModule.DBModule.getValueBeforeWeight()
        CanvasModule.CanvasModule.draw(wL, wB, 0, getContext("2d"), 1)
    }
    MouseArea {
        anchors.fill: parent
        onClicked: {
            pageStack.push(Qt.resolvedUrl("AddWeightPage.qml"))
        }
    }
    onVisibleChanged: {
        if (visible) {
            console.log("vis")
            if (weightCanvas.available) {
                var wL = DBModule.DBModule.getLastWeight()
                var wB = DBModule.DBModule.getValueBeforeWeight()
                var context = weightCanvas.getContext("2d")
                if (context === null) {
                    console.error("context == null")
                    return
                }
                weightCanvas.markDirty(0, 0, 240, 240)
                context.reset()
                context = null
                context = weightCanvas.getContext("2d")
                CanvasModule.CanvasModule.draw(wL, wB, 0, context, 1)
            }
        }
    }
}
