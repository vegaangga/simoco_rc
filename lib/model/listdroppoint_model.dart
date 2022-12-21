// To parse this JSON data, do
//
//     final listDroppoint = listDroppointFromJson(jsonString);

import 'dart:convert';

List<listDroppointModel> listDroppointModelFromJson(String str) => List<listDroppointModel>.from(json.decode(str).map((x) => listDroppointModel.fromJson(x)));

String listDroppointModelToJson(List<listDroppointModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class listDroppointModel {
    listDroppointModel({
        this.droppointId,
        this.transaksiId,
        this.noResi,
        this.idContainer,
        this.noContainer,
        this.idJadwal,
        this.kdtujuanPelabuhan,
        this.tujuanPelabuhan,
        this.kdpelabuhanSekarang,
        this.pelabuhanSekarang,
    });

    int? droppointId;
    int? transaksiId;
    String? noResi;
    int? idContainer;
    String? noContainer;
    int? idJadwal;
    String? kdtujuanPelabuhan;
    String? tujuanPelabuhan;
    String? kdpelabuhanSekarang;
    String? pelabuhanSekarang;

    factory listDroppointModel.fromJson(Map<String, dynamic> json) => listDroppointModel(
        droppointId: json["droppoint_id"],
        transaksiId: json["transaksi_id"],
        noResi: json["no_resi"],
        idContainer: json["id_container"],
        noContainer: json["no_container"],
        idJadwal: json["id_jadwal"],
        kdtujuanPelabuhan: json["kdtujuan_pelabuhan"],
        tujuanPelabuhan: json["tujuan_pelabuhan"],
        kdpelabuhanSekarang: json["kdpelabuhan_sekarang"],
        pelabuhanSekarang: json["pelabuhan_sekarang"],
    );

    Map<String, dynamic> toJson() => {
        "droppoint_id": droppointId,
        "transaksi_id": transaksiId,
        "no_resi": noResi,
        "id_container": idContainer,
        "no_container": noContainer,
        "id_jadwal": idJadwal,
        "kdtujuan_pelabuhan": kdtujuanPelabuhan,
        "tujuan_pelabuhan": tujuanPelabuhan,
        "kdpelabuhan_sekarang": kdpelabuhanSekarang,
        "pelabuhan_sekarang": pelabuhanSekarang,
    };
}
