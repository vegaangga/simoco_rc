import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:simoco_rc/constant/string_constant.dart';
import 'package:simoco_rc/model/container_model.dart';
import 'package:flutter/material.dart';

class ContainerProvider extends ChangeNotifier {
  //DEFINISIKAN PRIVATE VARIABLE DENGAN TYPE List dan VALUENYA MENGGUNAKAN FORMAT ContainerModel
  //DEFAULTNYA KITA BUAT KOSONG
  List<ContainerModel> _data = [];
  //KARENA PRIVATE VARIABLE TIDAK BISA DIAKSES OLEH CLASS/FILE LAINNYA, MAKA DIPERLUKAN GETTER YANG BISA DIAKSES SECARA PUBLIC, ADAPUN VALUENYA DIAMBIL DARI _DATA
  List<ContainerModel> get dataDroppoint => _data;

  //BUAT FUNGSI UNTUK MELAKUKAN REQUEST DATA KE SERVER / API
  Future<List<ContainerModel>> getDroppoint() async {
    // String url = 'https://2d43-103-174-113-10.ap.ngrok.io/api/droppoint';
    // final response = await http.get(url); //LAKUKAN REQUEST DATA
    var response = await http.get(Uri.parse('${StringConstant.baseUrl}/monitoring'));
    //JIKA STATUSNYA BERHASIL ATAU = 200
    if (response.statusCode == 200) {
      //MAKA KITA FORMAT DATANYA MENJADI MAP DENGNA KEY STRING DAN VALUE DYNAMIC
      final result = json.decode(response.body)['data'].cast<Map<String, dynamic>>();
      //KEMUDIAN MAPPING DATANYA UNTUK KEMUDIAN DIUBAH FORMATNYA SESUAI DENGAN ContainerModel DAN DIPASSING KE DALAM VARIABLE _DATA
      _data = result.map<ContainerModel>((json) => ContainerModel.fromJson(json)).toList();
      return _data;
    } else {
      throw Exception();
    }
  }
}