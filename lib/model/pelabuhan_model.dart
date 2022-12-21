// To parse this JSON data, do
//
//     final province = provinceFromJson(jsonString);

import 'dart:convert';

Pelabuhan provinceFromJson(String str) => Pelabuhan.fromJson(json.decode(str));

String provinceToJson(Pelabuhan data) => json.encode(data.toJson());

class Pelabuhan {
  Pelabuhan({
    required this.kodePelabuhan,
    required this.namaPelabuhan,
  });

  String kodePelabuhan;
  String namaPelabuhan;

  factory Pelabuhan.fromJson(Map<String, dynamic> json) => Pelabuhan(
        kodePelabuhan: json["kode_pelabuhan"],
        namaPelabuhan: json["nama_pelabuhan"],
      );

  Map<String, dynamic> toJson() => {
        "kode_pelabuhan": kodePelabuhan,
        "nama_pelabuhan": namaPelabuhan,
      };

  // Agar fungsi search berfungsi
  @override
  String toString() => namaPelabuhan;
}