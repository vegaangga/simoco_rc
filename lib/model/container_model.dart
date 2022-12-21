class ContainerModel {
  int? id;
  String? topic;

  //BUAT CONSTRUCTOR AGAR KETIKA CLASS INI DILOAD, MAKA DATA YANG DIMINTA HARUS DIPASSING SESUAI TIPE DATA YANG DITETAPKAN
  ContainerModel({
    this.id,
    this.topic,
  });

  //FUNGSI INI UNTUK MENGUBAH FORMAT DATA DARI JSON KE FORMAT YANG SESUAI DENGAN EMPLOYEE MODEL
  ContainerModel.fromJson(Map<String, dynamic> json) {
    id: json['id'];
    topic: json['topic'];
  }

}