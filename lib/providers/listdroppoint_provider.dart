import 'package:shared_preferences/shared_preferences.dart';
import 'package:simoco_rc/constant/string_constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:simoco_rc/model/listdroppoint_model.dart';

class ListDroppointProvider extends ChangeNotifier {

  List<listDroppointModel> _data = [];
  List<listDroppointModel> get dataDroppoint => _data;
  String? id;

  Future<List<listDroppointModel>> getDroppoint() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    id = pref.getString("idContainer");
    var response = await http.get(Uri.parse('${StringConstant.baseUrl}/droppoint/topicid=$id'));
    if (response.statusCode == 200) {
      final result = json.decode(response.body).cast<Map<String, dynamic>>();
      _data = result.map<listDroppointModel>((json) => listDroppointModel.fromJson(json)).toList();
      return _data;
    } else {
      throw Exception();
    }
  }
}