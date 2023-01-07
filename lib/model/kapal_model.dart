// To parse this JSON data, do
//
//     final kapal = kapalFromJson(jsonString);

import 'dart:convert';

List<Kapal> kapalFromJson(String str) => List<Kapal>.from(json.decode(str).map((x) => Kapal.fromJson(x)));

String kapalToJson(List<Kapal> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Kapal {
    Kapal({
        this.id,
        this.imo,
        this.namaKapal,
    });

    int? id;
    String? imo;
    String? namaKapal;

    factory Kapal.fromJson(Map<String, dynamic> json) => Kapal(
        id: json["id"],
        imo: json["IMO"],
        namaKapal: json["nama_kapal"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "IMO": imo,
        "nama_kapal": namaKapal,
    };
}
