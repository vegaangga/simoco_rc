import 'package:simoco_rc/model/mqtt.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:simoco_rc/constant/string_constant.dart';


class MqttProvider extends ChangeNotifier {
  List<mqttModel> _data = [];
  final _valTopic = 1;


  List<mqttModel> get dataMqtt => _data;

  //BUAT FUNGSI UNTUK MELAKUKAN REQUEST DATA KE SERVER / API
  Future<List<mqttModel>> getMqtt() async {
    String url = '${StringConstant.baseUrl}/monitoring/topicid=$_valTopic';

    var response = await http.get(Uri.parse(url));

    //JIKA STATUSNYA BERHASIL ATAU = 200
    if (response.statusCode == 200) {
      //MAKA KITA FORMAT DATANYA MENJADI MAP DENGNA KEY STRING DAN VALUE DYNAMIC
      final result = json.decode(response.body)['data'].cast<Map<String, dynamic>>();
      //KEMUDIAN MAPPING DATANYA UNTUK KEMUDIAN DIUBAH FORMATNYA SESUAI DENGAN mqttModel DAN DIPASSING KE DALAM VARIABLE _DATA
      _data = result.map<mqttModel>((json) => mqttModel.fromJson(json)).toList();
      return _data;
    } else {
      throw Exception();
    }
  }

}