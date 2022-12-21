class InfoModel {
    int? devid;
    DateTime? timeStr;
    double? time;
    double? tmp1;
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

 InfoModel({
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

  @override
  String toString() {
    return 'InfoModel{DEVID: $devid, TMIE_STR: $timeStr,TIME: $time, TMP1: $tmp1, HMD1:$hmd1, TMP2:$tmp2,HM2:$hmd2,AVG_TMP:$avgTmp,AVG_HMD:$avgHmd,GPS:$gps,LAT:$lat,LON:$lon,LAT_STRING:$latString,LON_STRING:$lonString,EVAP:$evap,COND:$cond,COMP:$comp,HEAT:$heat}';
  }

  //

  factory InfoModel.fromJson(Map<String, dynamic> json) {
      return InfoModel (
        devid: json["DEVID"],
        timeStr: DateTime.parse(json["TIME_STR"]),
        time: json["TIME"].toDouble(),
        tmp1: json["TMP1"].toDouble(),
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
    }

    // Map<String, dynamic> toJson() => <String, dynamic>{
    //     "DEVID": devid.toString(),
    //     "TIME_STR": timeStr?.toIso8601String(),
    //     "TIME": time,
    //     "TMP1": tmp1,
    //     "HMD1": hmd1,
    //     "TMP2": tmp2,
    //     "HMD2": hmd2,
    //     "AVG_TMP": avgTmp,
    //     "AVG_HMD": avgHmd,
    //     "GPS": gps,
    //     "LAT": lat,
    //     "LON": lon,
    //     "LAT_STRING": latString,
    //     "LON_STRING": lonString,
    //     "EVAP": evap,
    //     "COND": cond,
    //     "COMP": comp,
    //     "HEAT": heat,
    // };
}

class SampleModel {
  int? id;
  int? topicid;
  int? kapasitas;
  String? topic;
  InfoModel? value;

  SampleModel({
  this.id,
  this.topicid,
  this.topic,
  this.kapasitas,
  this.value
    });
  @override
  String toString() {
    return 'SampleModel{id: $id, topicid: $topicid,topic:$topic, kapasitas:$kapasitas,value: $value}';
  }
  factory SampleModel.fromJson(Map<String, dynamic> json) {
    return SampleModel(
      id: json["id"],
      topicid: json["topicid"],
      topic : json["topic"],
      kapasitas: json["kapasitas"],
      value: InfoModel.fromJson(json["value"]),
    );
  }

  // Map<String, dynamic> toJson() => <String, dynamic>{
  //       "id": id,
  //       "topicid": topicid,
  //       "value": value.toJson(),
  //   };
}


