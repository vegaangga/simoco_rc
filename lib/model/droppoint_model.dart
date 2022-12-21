class DroppointModel {
  int? id;
  int? idTransaksi;
  String? pelabuhan;
  String? namaPelabuhan;
  String? keterangan;

  //BUAT CONSTRUCTOR AGAR KETIKA CLASS INI DILOAD, MAKA DATA YANG DIMINTA HARUS DIPASSING SESUAI TIPE DATA YANG DITETAPKAN
  DroppointModel({
    this.id,
    this.idTransaksi,
    this.pelabuhan,
    this.namaPelabuhan,
    this.keterangan,
  });

  //FUNGSI INI UNTUK MENGUBAH FORMAT DATA DARI JSON KE FORMAT YANG SESUAI DENGAN EMPLOYEE MODEL
  factory DroppointModel.fromJson(Map<String, dynamic> json) => DroppointModel(
    id: json['id'],
    idTransaksi: json['id_transaksi'],
    pelabuhan: json['pelabuhan'],
    namaPelabuhan: json['nama_pelabuhan'],
    keterangan: json['keterangan'],
  );
}