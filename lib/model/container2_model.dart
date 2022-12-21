class Book {
  int? id;
  String? noContainer;
  int? kapasitas;
  int? suhuKetetapan;

  Book({
    this.id,
    this.noContainer,
    this.kapasitas,
    this.suhuKetetapan,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        id: json['id'],
        noContainer: json['no_container'],
        kapasitas: json['kapasitas'],
        suhuKetetapan: json['suhu_ketetapan'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'no_container': noContainer,
        'kapasitas': kapasitas,
        'suhu_ketetapan': suhuKetetapan,
      };
}