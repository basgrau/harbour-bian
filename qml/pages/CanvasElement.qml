/*
    harbour-bian
    Copyright (C) 2015  Sebastian Weiler

    See LICENSE.
 */
/*
Version:   0.1
Date:      17.08.2015
*/
import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0
import "CanvasModule.js" as CanvasModule
import "DBModule.js" as DBModule

Canvas {
    id: canvasElement

    //properties to define behavior
    property int canvasType
    property int defaultSize: 240

    //size, default
    width: defaultSize
    height: defaultSize

    MouseArea {
        anchors.fill: parent
        onClicked: {
            var dialogToShow = Qt.createComponent("AddValueDialog.qml")
            var placeholderL = ""
            var placeholderS = ""
            var canvasModule = CanvasModule.CanvasModule

            if(canvasType === canvasModule.getTypeWeight()){                
                placeholderS = "weight"
                placeholderL = "please enter your current weight"
            }
            else if(canvasType === canvasModule.getTypeGlucose()){
                placeholderS = "glucose"
                placeholderL = "please enter your current glucose level"

            }else{
                console.error("Canvas-Type " + canvasType + " not found!")
                return
            }

             pageStack.push( dialogToShow, {dialogType: canvasType,placeholderLong:placeholderL,placeholderShort:placeholderS});
        }
    }

    onPaint: {
        getSizeDependingOnScreenWidth()
        var dbModule = DBModule.DBModule
        var canvasModule = CanvasModule.CanvasModule
        console.log("defaultSize: "+defaultSize)
        canvasModule.init(defaultSize)
        console.log(canvasType + "-"+ canvasModule.getTypeWeight())
        if(canvasType === canvasModule.getTypeWeight()){
            var wL = dbModule.getLastWeight()
            var wB = dbModule.getValueBeforeWeight()
            var wA = dbModule.getAverageWeight()
            CanvasModule.CanvasModule.draw(wL, wB, wA, getContext("2d"), canvasModule.getTypeWeight())
        }
        else if(canvasType === canvasModule.getTypeGlucose()){
            console.log(canvasType)
            var gL = dbModule.getLastGlucose()
            var gB = dbModule.getValueBeforeGlucose()
            var gA = dbModule.getAverageGlucose()
            console.log(gL)
            console.log(gB)
            console.log(gA)
            CanvasModule.CanvasModule.draw(gL, gB, gA, getContext("2d"), canvasModule.getTypeGlucose())
        }else{
            console.error("Canvas-Type " + canvasType + " not found!")
            return
        }
    }

    onVisibleChanged: {
        if (visible) {
           getSizeDependingOnScreenWidth()
           if (canvasElement.available) {
               var context = canvasElement.getContext("2d")
               if (context === null) {
                   console.error("context == null")
                   return
               }
               canvasElement.markDirty(0, 0, defaultSize, defaultSize)
               context.reset()
               context = null
               context = canvasElement.getContext("2d")

               // place in seperate function
               var dbModule = DBModule.DBModule
               var canvasModule = CanvasModule.CanvasModule;
               canvasModule.init(defaultSize)
               if(canvasType === canvasModule.getTypeWeight()){
                   var wL = dbModule.getLastWeight()
                   var wB = dbModule.getValueBeforeWeight()
                   var wA = dbModule.getAverageWeight()
                   CanvasModule.CanvasModule.draw(wL, wB, wA, getContext("2d"), canvasModule.getTypeWeight())
               }
               else if(canvasType === canvasModule.getTypeGlucose()){
                   var gL = dbModule.getLastGlucose()
                   var gB = dbModule.getValueBeforeGlucose()
                   var gA = dbModule.getAverageGlucose()
                   CanvasModule.CanvasModule.draw(gL, gB, gA, getContext("2d"), canvasModule.getTypeGlucose())
               }else{
                   console.error("Canvas-Type " + canvasType + " not found!")
                   return
               }

            }
        }
    }

    function getSizeDependingOnScreenWidth(){
        defaultSize = ((parent.width/2)-10)
    }
}
