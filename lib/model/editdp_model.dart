// To parse this JSON data, do
//
//     final EditDP = EditDPFromJson(jsonString);

import 'dart:convert';

List<EditDP> EditDPFromJson(String str) => List<EditDP>.from(json.decode(str).map((x) => EditDP.fromJson(x)));

String EditDPToJson(List<EditDP> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EditDP {
    EditDP({
        this.id,
        this.idTransaksi,
        this.pelabuhan,
        this.keterangan,

    });

    int? id;
    int? idTransaksi;
    String? pelabuhan;
    String? keterangan;

    factory EditDP.fromJson(Map<String, dynamic> json) => EditDP(
        id: json["id"],
        idTransaksi: json["id_transaksi"],
        pelabuhan: json["pelabuhan"],
        keterangan: json["keterangan"],

    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "id_transaksi": idTransaksi,
        "pelabuhan": pelabuhan,
        "keterangan": keterangan,

    };
}
