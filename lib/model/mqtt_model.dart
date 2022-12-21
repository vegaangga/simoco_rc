// To parse this JSON data, do
//
//     final mqtt = mqttFromJson(jsonString);

import 'dart:convert';

List<Mqtt> mqttFromJson(String str) => List<Mqtt>.from(json.decode(str).map((x) => Mqtt.fromJson(x)));

String mqttToJson(List<Mqtt> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Mqtt {
    Mqtt({
        this.id,
        this.topic,
        this.kapasitas,
        this.value,
    });

    int? id;
    String? topic;
    int? kapasitas;
    Value? value;

    factory Mqtt.fromJson(Map<String, dynamic> json) => Mqtt(
        id: json["id"],
        topic: json["topic"],
        kapasitas: json["kapasitas"],
        value: Value.fromJson(json["value"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "topic": topic,
        "kapasitas": kapasitas,
        "value": value?.toJson(),
    };
}

class Value {
    Value({
        this.devid,
        this.timeStr,
        this.time,
        this.tmp1,
        this.hmd1,
        this.tmp2,
        this.hmd2,
        this.avgTmp,
        this.avgHmd,
        this.gps,
        this.lat,
        this.lon,
        this.latString,
        this.lonString,
        this.evap,
        this.cond,
        this.comp,
        this.heat,
    });

    int? devid;
    DateTime? timeStr;
    double? time;
    int? tmp1;
    double? hmd1;
    double? tmp2;
    double? hmd2;
    double? avgTmp;
    double? avgHmd;
    String? gps;
    String? lat;
    String? lon;
    String? latString;
    String? lonString;
    bool? evap;
    bool? cond;
    bool? comp;
    bool? heat;

    factory Value.fromJson(Map<String, dynamic> json) => Value(
        devid: json["DEVID"],
        timeStr: DateTime.parse(json["TIME_STR"]),
        time: json["TIME"].toDouble(),
        tmp1: json["TMP1"],
        hmd1: json["HMD1"].toDouble(),
        tmp2: json["TMP2"].toDouble(),
        hmd2: json["HMD2"].toDouble(),
        avgTmp: json["AVG_TMP"].toDouble(),
        avgHmd: json["AVG_HMD"].toDouble(),
        gps: json["GPS"],
        lat: json["LAT"],
        lon: json["LON"],
        latString: json["LAT_STRING"],
        lonString: json["LON_STRING"],
        evap: json["EVAP"],
        cond: json["COND"],
        comp: json["COMP"],
        heat: json["HEAT"],
    );

    Map<String, dynamic> toJson() => {
        "DEVID": devid,
        "TIME_STR": timeStr?.toIso8601String(),
        "TIME": time,
        "TMP1": tmp1,
        "HMD1": hmd1,
        "TMP2": tmp2,
        "HMD2": hmd2,
        "AVG_TMP": avgTmp,
        "AVG_HMD": avgHmd,
        "GPS": gps,
        "LAT": lat,
        "LON": lon,
        "LAT_STRING": latString,
        "LON_STRING": lonString,
        "EVAP": evap,
        "COND": cond,
        "COMP": comp,
        "HEAT": heat,
    };
}
