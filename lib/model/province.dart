// To parse this JSON data, do
//
//     final province = provinceFromJson(jsonString);

import 'dart:convert';

Province provinceFromJson(String str) => Province.fromJson(json.decode(str));

String provinceToJson(Province data) => json.encode(data.toJson());

class Province {
  Province({
    required this.kodePelabuhan,
    required this.namaPelabuhan,
  });

  String kodePelabuhan;
  String namaPelabuhan;

  factory Province.fromJson(Map<String, dynamic> json) => Province(
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