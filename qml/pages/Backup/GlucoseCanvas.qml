import QtQuick 2.0
import Sailfish.Silica 1.0
import "CanvasModule.js" as CanvasModule
import QtQuick.LocalStorage 2.0
import "DBModule.js" as DBModule

Canvas {
    id: glucoseCanvas
    width: 240
    height: 240
    onPaint: {
        var gL = DBModule.DBModule.getLastGlucose()
        var gB = DBModule.DBModule.getValueBeforeGlucose()
        var gA = DBModule.DBModule.getAverageGlucose()
        CanvasModule.CanvasModule.draw(gL, gB, gA, getContext("2d"), 0)
    }
    MouseArea {
        anchors.fill: parent
        onClicked: {
            pageStack.push(Qt.resolvedUrl("AddGlucosePage.qml"))
        }
    }
    onVisibleChanged: {
        if (visible) {
            if (glucoseCanvas.available) {
                var gL = DBModule.DBModule.getLastGlucose()
                var gB = DBModule.DBModule.getValueBeforeGlucose()
                var gA = DBModule.DBModule.getAverageGlucose()

                var contextG = glucoseCanvas.getContext("2d")
                if (contextG === null) {
                    return
                }

                contextG.reset()
                contextG = glucoseCanvas.getContext("2d")

                glucoseCanvas.update()

                CanvasModule.CanvasModule.draw(gL, gB, gA, contextG, 0)
            }
        }
    }
}
