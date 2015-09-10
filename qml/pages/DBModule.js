/*
    harbour-bian
    Copyright (C) 2015  Sebastian Weiler

    See LICENSE.
 */
/*
 Version:   0.1
   Date:      21.08.2015
      Use:  DBModule, used for db queries.
         */
var DBModule = (function () {
    var db = LocalStorage.openDatabaseSync("BianDB", "1.0",
                                        "BianDB", 1000000);

    var INIT_SQL_WEIGHT_TABLE = 'CREATE TABLE IF NOT EXISTS WeightLevel (stamp TEXT, weight INT)';
    var INIT_SQL_GLUCOSELEVEL_TABLE = 'CREATE TABLE IF NOT EXISTS GlucoseLevel (stamp TEXT, glucoseVal INT)';

    //TODO: Save/ store
    //Start hypoglycemia                 -> startHypo
    // Start hyperglycemia              -> startHyper
    // lowest comfortable               -> lowestComformtable
    //highest comfortable               -> highestComfortable
    //Beginn to high but not Dangerous -> beginToHigh
    // beginToLowWeight
    //beginToHighWeigt
    //optimalWeightLowest
    //optimalWeightHighest

    var typeGlucose = 1;
    function getTypeGlucose(){
        return typeGlucose;
    }

    var typeWeight = 2;
    function getTypeWeight(){
        return typeWeight;
    }

    function initTable(type) {
        db.transaction(function (tx) {
            if(type === typeWeight){
                tx.executeSql(INIT_SQL_WEIGHT_TABLE);
                console.log("init weight table");
            }else if(type === typeGlucose){
                tx.executeSql(INIT_SQL_GLUCOSELEVEL_TABLE);
                console.log("init glucose table");
            }
        });
    }

    function saveWeight(date, weight) {
        initTable(typeWeight);
        try{
        var weightValue = parseInt(weight);
        }catch(e){
            console.error(e, "DBModule:save");
            return;
            throw new Error("Not an valid value");
        }

        db.transaction(function (tx) {
            try {var r = tx.executeSql(
                            'INSERT INTO WeightLevel (stamp,weight)VALUES(?,?)',
                            [date, weightValue]);
            } catch (e) {
                console.error(e,"DBModule:save");
            }
        });
    }

    function getLastWeight() {
        initTable(typeWeight);
        var lastWeight = 0;
        db.transaction(function (tx) {
            try {
                var rs = tx.executeSql('SELECT * FROM WeightLevel');
                var resultsCount = rs.rows.length;
                if(resultsCount === 0){
                    return 0;
                }else{
                    lastWeight = rs.rows.item(rs.rows.length-1).weight;
                }
            } catch (e) {
                console.error(e,"DBModule:getLastWeight");
            }
        });

        return lastWeight;
    }

    function getValueBeforeWeight() {
        initTable(typeWeight);
        var beforeWeight= 0;
        db.transaction(function (tx) {
            try {
                var rs = tx.executeSql('SELECT * FROM WeightLevel');
                var resultsCount = rs.rows.length;
                if(resultsCount === 0){
                    return 0;
                }else if (resultsCount === 1){
                    return 0
                }else{
                    var itemG = rs.rows.item(resultsCount-2);
                    beforeWeight = itemG.weight;
                }
            } catch (e) {
                console.error(e,"DBModule:getValueBeforeWeight");
            }
        });

        return beforeWeight;
    }

    function getAverageWeight(){
        initTable(typeWeight);
        var averageWeight = 0;
        db.transaction(function (tx) {
            try {
                var rs = tx.executeSql('SELECT * FROM WeightLevel');
                var resultsCount = rs.rows.length;
                if(resultsCount === 0){
                    return 0;
                }else if (resultsCount === 1){
                    return rs.rows.item(resultsCount-1).weight;
                }else{
                    for (var i = 0; i < resultsCount; i++) {
                        averageWeight += rs.rows.item(i).weight;
                    }
                    averageWeight = (averageWeight/(resultsCount-1.0)).toFixed(0);
                }
            } catch (e) {
                console.error(e,"DBModule:getAverageWeight");
            }
        });

        return averageWeight;
    }

    function getWeightFromLast14Entries(){
        initTable(typeWeight);
        var arr  = [];
        db.transaction(function (tx) {
            try {
                var rs = tx.executeSql('SELECT * FROM WeightLevel ORDER BY stamp DESC LIMIT 14');
                var resultsCount = rs.rows.length;
                if(resultsCount === 0){
                    return null;
                }else{
                    for (var i = 0; i < resultsCount; i++) {
                        arr.push({stamp: rs.rows.item(i).stamp, weight: rs.rows.item(i).weight});
                    }
                }
            } catch (e) {
                console.error(e,"DBModule:getAverageWeight");
            }
        });

        return arr;
    }

    function saveGlucose(date, glucose) {
        initTable(typeGlucose);
        try{
            var glucoseValue = parseInt(glucose);
        }catch(e){
            console.error(e, "DBModule:save");
            return;
            throw new Error("Not an valid value");
        }

        db.transaction(function (tx) {
            try {var r = tx.executeSql(
                            'INSERT INTO GlucoseLevel (stamp,glucoseVal)VALUES(?,?)',
                            [date, glucoseValue]);
                console.log("value " + glucoseValue + " added");
            } catch (e) {
                console.error(e,"DBModule:save");
            }
        });
    }

    function getLastGlucose() {
        initTable(typeGlucose);
        var lastGlucose = 0;
        db.transaction(function (tx) {
            try {
                var rs = tx.executeSql('SELECT * FROM GlucoseLevel');
                var resultsCount = rs.rows.length;
                if(resultsCount === 0){
                    return 0;
                }else{
                    var itemG = rs.rows.item(resultsCount-1);
                    lastGlucose = itemG.glucoseVal;
                }
            } catch (e) {
                console.error(e,"DBModule:getLastGlucose");
            }
        });

        console.log(lastGlucose, "DBModule:getLastGlucose");
        return lastGlucose;
    }

    function getValueBeforeGlucose() {
        initTable(typeGlucose);
        var beforeGlucose = 0;
        db.transaction(function (tx) {
            try {
                var rs = tx.executeSql('SELECT * FROM GlucoseLevel');
                var resultsCount = rs.rows.length;
                if(resultsCount === 0){
                    return 0;
                }else if (resultsCount === 1){
                    return 0
                }else{
                    var itemG = rs.rows.item(resultsCount-2);
                    beforeGlucose = itemG.glucoseVal;
                }
            } catch (e) {
                console.error(e,"DBModule:getValueBeforeGlucose");
            }
        });

        return beforeGlucose;
    }

    function getAverageGlucose(){
        initTable(typeGlucose);
        var averageGlucose = 0;
        db.transaction(function (tx) {
            try {
                var rs = tx.executeSql('SELECT * FROM GlucoseLevel');
                var resultsCount = rs.rows.length;
                if(resultsCount === 0){
                    return 0;
                }else if (resultsCount === 1){
                    return rs.rows.item(resultsCount-1).glucoseVal;
                }else{
                    for (var i = 0; i < resultsCount; i++) {
                        averageGlucose += rs.rows.item(i).glucoseVal;
                    }
                    averageGlucose = (averageGlucose/(resultsCount-1.0)).toFixed(0);
                }
            } catch (e) {
                console.error(e,"DBModule:getAverageGlucose");
            }
        });

        return averageGlucose;
    }

    function getGlucoseFromLast14Entries(){
        initTable(typeGlucose);
        var arr  = [];
        db.transaction(function (tx) {
            try {
                var rs = tx.executeSql('SELECT * FROM GlucoseLevel ORDER BY stamp DESC LIMIT 14');
                var resultsCount = rs.rows.length;
                if(resultsCount === 0){
                    return null;
                }else{
                    for (var i = 0; i < resultsCount; i++) {
                        arr.push({stamp: rs.rows.item(i).stamp, glucose: rs.rows.item(i).glucoseVal});
                    }
                }
            } catch (e) {
                console.error(e,"DBModule:getAverageWeight");
            }
        });

        return arr;
    }

    function dropTable(type) {
        db.transaction(function (tx) {
            try{
                if(type === typeWeight){
                    tx.executeSql('DROP TABLE WeightLevel');
                }else if(type === typeGlucose){
                    tx.executeSql('DROP TABLE GlucoseLevel');
                }
            }catch(e){
                console.error(e, "DBModule:dropTable");
            }
        });
    }

    return {
        initTable: initTable,
        getLastWeight: getLastWeight,
        getValueBeforeWeight: getValueBeforeWeight,
        getAverageWeight: getAverageWeight,
        getWeightFromLast14Entries: getWeightFromLast14Entries,
        saveWeight: saveWeight,
        getLastGlucose: getLastGlucose,
        getValueBeforeGlucose: getValueBeforeGlucose,
        getAverageGlucose: getAverageGlucose,
        getGlucoseFromLast14Entries: getGlucoseFromLast14Entries,
        saveGlucose: saveGlucose,
        _getTypeGlucose: getTypeGlucose,
        _getTypeWeight: getTypeWeight,
        _dropTable: dropTable
    }
})();
