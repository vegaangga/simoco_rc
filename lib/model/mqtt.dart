// To parse this JSON data, do
//
//     final mqttModelModel = MqttModelModelFromJson(jsonString);

import 'dart:convert';

mqttModel mqttModelFromJson(String str) => mqttModel.fromJson(json.decode(str));

String mqttModelToJson(mqttModel data) => json.encode(data.toJson());

class mqttModel {
    mqttModel({
        required this.id,
        required this.topicid,
        required this.value,
    });

    int id;
    int topicid;
    Value value;

    factory mqttModel.fromJson(Map<String, dynamic> json) => mqttModel(
        id: json["id"],
        topicid: json["topicid"],
        value: Value.fromJson(json["value"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "topicid": topicid,
        "value": value.toJson(),
    };
}

class Value {
    int devid;
    DateTime timeStr;
    double time;
    double tmp1;
    double hmd1;
    double tmp2;
    double hmd2;
    double avgTmp;
    double avgHmd;
    // String gps;
    // String lat;
    // String lon;
    // String latString;
    // String lonString;
    bool evap;
    bool cond;
    bool comp;
    bool heat;

    Value({
        required this.devid,
        required this.timeStr,
        required this.time,
        required this.tmp1,
        required this.hmd1,
        required this.tmp2,
        required this.hmd2,
        required this.avgTmp,
        required this.avgHmd,
        //required this.gps,
        // required this.lat,
        // required this.lon,
        // required this.latString,
        // required this.lonString,
        required this.evap,
        required this.cond,
        required this.comp,
        required this.heat,
    });

  //   @override
  //   String toString() {
  //   return 'Value{DEVID: $devid,repository: $repository}';
  // }

    // factory Value.fromJson(Map<String, dynamic> json) => Value(
    //     devid: json["DEVID"],
    //     timeStr: DateTime.parse(json["TIME_STR"]),
    //     time: json["TIME"].toDouble(),
    //     tmp1: json["TMP1"].toDouble(),
    //     hmd1: json["HMD1"].toDouble(),
    //     tmp2: json["TMP2"].toDouble(),
    //     hmd2: json["HMD2"].toDouble(),
    //     avgTmp: json["AVG_TMP"].toDouble(),
    //     avgHmd: json["AVG_HMD"].toDouble(),
    //     //gps: json["GPS"],
    //     // lat: json["LAT"],
    //     // lon: json["LON"],
    //     // latString: json["LAT_STRING"],
    //     // lonString: json["LON_STRING"],
    //     evap: json["EVAP"],
    //     cond: json["COND"],
    //     comp: json["COMP"],
    //     heat: json["HEAT"],
    // );
    factory Value.fromJson(Map<String, dynamic> json) {
      return Value (
        devid: json["DEVID"],
        timeStr: DateTime.parse(json["TIME_STR"]),
        time: json["TIME"].toDouble(),
        tmp1: json["TMP1"].toDouble(),
        hmd1: json["HMD1"].toDouble(),
        tmp2: json["TMP2"].toDouble(),
        hmd2: json["HMD2"].toDouble(),
        avgTmp: json["AVG_TMP"].toDouble(),
        avgHmd: json["AVG_HMD"].toDouble(),
        //gps: json["GPS"],
        // lat: json["LAT"],
        // lon: json["LON"],
        // latString: json["LAT_STRING"],
        // lonString: json["LON_STRING"],
        evap: json["EVAP"],
        cond: json["COND"],
        comp: json["COMP"],
        heat: json["HEAT"],
      );
    }
    Map<String, dynamic> toJson() => {
        "DEVID": devid,
        "TIME_STR": timeStr.toIso8601String(),
        "TIME": time,
        "TMP1": tmp1,
        "HMD1": hmd1,
        "TMP2": tmp2,
        "HMD2": hmd2,
        "AVG_TMP": avgTmp,
        "AVG_HMD": avgHmd,
        //"GPS": gps,
        // "LAT": lat,
        // "LON": lon,
        // "LAT_STRING": latString,
        // "LON_STRING": lonString,
        "EVAP": evap,
        "COND": cond,
        "COMP": comp,
        "HEAT": heat,
    };
}
