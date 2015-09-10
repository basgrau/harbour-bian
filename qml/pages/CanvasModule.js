/*
    harbour-bian
    Copyright (C) 2015  Sebastian Weiler

    See LICENSE.
 */
var CanvasModule = (function () {
    var defaultCircleSize = 240;
    var radius = defaultCircleSize/2;
    var fontSizeSmall = 14;
    var fontSizeLarge = 32;

    var maxValue = 300;

    var circ = Math.PI * 2;
    var quart = Math.PI / 2;

    var dangerColor = 'red';
    var okColor = '#99CC33';
    var notSoGoodColor = 'yellow';


    var typeGlucose = 1;
    function getTypeGlucose(){
        return typeGlucose;
    }
    var typeWeight = 2;
    function getTypeWeight(){
        return typeWeight;
    }

    function init(screenSize){
        defaultCircleSize = screenSize;
        radius = defaultCircleSize/2;
        fontSizeSmall = ((screenSize > 420)?18:12);
        fontSizeLarge = ((screenSize > 420)?36:24);
        console.log(fontSizeLarge +"Large")
        console.log("Radius: " + radius)
    }

    function draw(current,lastValue,averageVal,context,type) {
        context.globalAlpha = 0.5;
        context.beginPath();
        context.lineCap = 'square';

        //TODO: different values for weight and glucose!
        if (current < 60) {
            context.strokeStyle = dangerColor;
        } else if (current < 80) {
            context.strokeStyle = notSoGoodColor;
        } else if (current < 140) {
            context.strokeStyle = okColor;
        } else if (current <= 220) {
            context.strokeStyle = notSoGoodColor;
        } else if (current > 220) {
            context.strokeStyle = dangerColor;
        }

        //Start hypoglycemia                 -> startHypo
        // Start hyperglycemia              -> startHyper
        // lowest comfortable               -> lowestComformtable
        //highest comfortable               -> highestComfortable
        //Beginn to high but not Dangerous -> beginToHigh
        // beginToLowWeight
        //beginToHighWeigt
        //optimalWeightLowest
        //optimalWeightHighest

        context.closePath();
        context.lineWidth = 18.0;
        context.fill();

        //ImageData
        var imd = context.getImageData(0, 0, defaultCircleSize, defaultCircleSize);
        context.putImageData(imd, 0, 0);

        //Beginn again with Path
        context.beginPath();
        context.arc(radius, radius, 70, -(quart),
                    ((circ) * current / maxValue) - quart, false);
        context.stroke();

        //Make text on Circle
        context.font = fontSizeLarge+"pt sans-serif";
        context.fillStyle = "white";
        console.log(type + "-"+ typeGlucose,"draw")
        context.fillText(current, defaultCircleSize - radius - 36, defaultCircleSize - radius);
        context.font = fontSizeLarge +"pt sans-serif";
        context.fillStyle = "white";
        context.fillText(((type === typeGlucose)?"\mg/dl":"kg"), defaultCircleSize - radius - 35, defaultCircleSize - radius + 20);
        context.font = fontSizeSmall+"pt sans-serif";
        context.fillStyle = "white";
        context.fillText(lastValue + "/" + averageVal, defaultCircleSize - radius - 36, defaultCircleSize - radius - 30);
    }
    return {
        init: init,
        draw: draw,
        getTypeGlucose: getTypeGlucose,
        getTypeWeight: getTypeWeight
    }
})();
