import 'package:shared_preferences/shared_preferences.dart';
import 'package:simoco_rc/constant/string_constant.dart';
import 'package:simoco_rc/model/dashboard_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DashboardService{
  String? id;

    Future<SampleModel> getMqttByTopic() async{
    SampleModel data;
    SharedPreferences pref = await SharedPreferences.getInstance();
      id = pref.getString("id");
    //var baseUrl = "https://edac-103-174-113-10.ap.ngrok.io/api/monitoring/topicid=$id";
    var response = await http.get(Uri.parse("${StringConstant.baseUrl}/monitoring/topicid=$id"));
    var it = jsonDecode(response.body);
    print(it);
    data = SampleModel.fromJson(it);
    return data;
  }
}