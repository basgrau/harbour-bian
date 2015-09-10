/*
    harbour-bian
    Copyright (C) 2015  Sebastian Weiler

    See LICENSE.
 */
/*
Version:   0.1
Date:      24.08.2015
*/
import QtQuick 2.0
import Sailfish.Silica 1.0
import "../jbQuick/Charts" 1.0
import QtQuick.LocalStorage 2.0
import "DBModule.js" as DBModule
import "../date.format.js" as DateFormat
import "SharedInfo.js" as Shared

Chart {
    id: chart_line

    property int defaultSize: 400

    width: defaultSize
    height: defaultSize

    chartAnimated: true
    chartAnimationEasing: Easing.InOutElastic
    chartAnimationDuration: 2000
    chartType: Charts.ChartType.LINE

    //properties to define behavior
    property int canvasType

    onVisibleChanged: {
        if(visible & Shared.isStartUp){
            drawChart()
        }
    }

    Component.onCompleted: drawChart()

    function drawChart(){
        getSizeDependingOnScreenWidth()
        var arr = []
        var labelValues = []
        var dataValues = []

        if (canvasType === DBModule.DBModule._getTypeWeight()) {
            arr = DBModule.DBModule.getWeightFromLast14Entries()
            for (var i = 0; i < arr.length; i++) {
                var stampWeightValue = arr[i].stamp
                labelValues.push(DateFormat.dateFormat(stampWeightValue,
                                                       "d/mm/yyyy HH:MM"))
                dataValues.push(arr[i].weight)
            }
        } else if (canvasType === DBModule.DBModule._getTypeGlucose()) {
            arr = DBModule.DBModule.getGlucoseFromLast14Entries()
            for (var i = 0; i < arr.length; i++) {
                var stampGlucoseValue = arr[i].stamp
                labelValues.push(DateFormat.dateFormat(stampGlucoseValue,
                                                       "d/mm/yyyy HH:MM"))
                dataValues.push(arr[i].glucose)
                console.log(arr[i].glucose)

            }
        } else {
            console.error("No known Chart-Type!")
            return
        }

        var ChartLineData = {
            labels: labelValues,
            datasets: [{
                    fillColor: "rgba(220,220,220,0.5)",
                    strokeColor: "rgba(220,220,220,1)",
                    pointColor: "rgba(220,220,220,1)",
                    pointStrokeColor: "#ffffff",
                    data: dataValues
                }]
        }
        chartData = ChartLineData

        var fontSize = 0
        if(defaultSize > 500){
            fontSize = 20
        }else{
            fontSize = 14
        }

        chartOptions = {
            scaleLabel: "<%=value%>",
            scaleFontFamily: "'Sail Sans Pro'",
            scaleFontSize: fontSize,
            scaleFontStyle: "normal",
            scaleFontColor: Theme.highlightColor
        };
    }

    function getSizeDependingOnScreenWidth(){
        defaultSize = (parent.width-50)
        console.log("default: " + defaultSize)
    }
}
