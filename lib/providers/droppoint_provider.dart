import 'package:simoco_rc/constant/string_constant.dart';
import 'package:simoco_rc/model/droppoint_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DroppointProvider extends ChangeNotifier {
  //DEFINISIKAN PRIVATE VARIABLE DENGAN TYPE List dan VALUENYA MENGGUNAKAN FORMAT DroppointMODEL
  //DEFAULTNYA KITA BUAT KOSONG
  List<DroppointModel> _data = [];
  //KARENA PRIVATE VARIABLE TIDAK BISA DIAKSES OLEH CLASS/FILE LAINNYA, MAKA DIPERLUKAN GETTER YANG BISA DIAKSES SECARA PUBLIC, ADAPUN VALUENYA DIAMBIL DARI _DATA
  List<DroppointModel> get dataDroppoint => _data;

  //BUAT FUNGSI UNTUK MELAKUKAN REQUEST DATA KE SERVER / API
  Future<List<DroppointModel>> getDroppoint() async {
    // String url = 'https://2d43-103-174-113-10.ap.ngrok.io/api/droppoint';
    // final response = await http.get(url); //LAKUKAN REQUEST DATA
    var response = await http.get(Uri.parse('${StringConstant.baseUrl}/alldroppoint'));
    //JIKA STATUSNYA BERHASIL ATAU = 200
    if (response.statusCode == 200) {
      //MAKA KITA FORMAT DATANYA MENJADI MAP DENGNA KEY STRING DAN VALUE DYNAMIC
      final result = json.decode(response.body).cast<Map<String, dynamic>>();
      //KEMUDIAN MAPPING DATANYA UNTUK KEMUDIAN DIUBAH FORMATNYA SESUAI DENGAN DroppointMODEL DAN DIPASSING KE DALAM VARIABLE _DATA
      _data = result.map<DroppointModel>((json) => DroppointModel.fromJson(json)).toList();
      return _data;
    } else {
      throw Exception();
    }
  }

  Future<bool> storeDroppoint(String id_transaksi, String pelabuhan, String keterangan) async {
  //String url = 'https://97f7-103-174-113-10.ap.ngrok.io/api/droppoint';
  //KIRIM REQUEST KE SERVER DENGAN MENGIRIMKAN DATA YANG AKAN DITAMBAHKAN PADA BODY
  final response = await http.post(Uri.parse("${StringConstant.baseUrl}/droppoint"), body: {
    'id_transaksi': id_transaksi,
    'pelabuhan': pelabuhan,
    'keterangan': keterangan
  });

  //DECODE RESPONSE YANG DITERIMA
  final result = json.decode(response.body);
  //LAKUKAN PENGECEKAN, JIKA STATUS CODENYA 200 DAN STATUS SUCCESS
  if (response.statusCode == 200 && result['status'] == 'success') {
    notifyListeners(); //MAKA INFORMASIKAN PADA LISTENERS BAHWA ADA DATA BARU
    return true;
  }
  return false;
}

//DroppointModel dp = DroppointModel();

Future<bool> deleteData(int id) async {
  final response = await http.delete(Uri.parse("${StringConstant.baseUrl}/droppoint/$id"));
  // final response = await dp.delete(
  //   "$baseUrl/api/profile/$id",
  //   headers: {"content-type": "application/json"},
  // );
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

}