import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simoco_rc/constant/string_constant.dart';
import 'package:simoco_rc/model/editdp_model.dart';

class UpdateDPProvider{
  String? id;

    Future<EditDP> getDrop() async{
    EditDP data;
    SharedPreferences pref = await SharedPreferences.getInstance();
      id = pref.getString("idDroppoint");
    //var baseUrl = "https://edac-103-174-113-10.ap.ngrok.io/api/monitoring/topicid=$id";
    var response = await http.get(Uri.parse("${StringConstant.baseUrl}/droppoint/edit/$id"));
    var it = jsonDecode(response.body);
    print(it);
    data = EditDP.fromJson(it);
    return data;
  }
}