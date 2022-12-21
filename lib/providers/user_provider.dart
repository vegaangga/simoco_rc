import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simoco_rc/constant/string_constant.dart';
import 'package:simoco_rc/model/user_model.dart';

class UserProvider{
  String? id;

    Future<User> getUser() async{
    User data;
    SharedPreferences pref = await SharedPreferences.getInstance();
      id = pref.getString("iduser");
    //var baseUrl = "https://edac-103-174-113-10.ap.ngrok.io/api/monitoring/topicid=$id";
    var response = await http.get(Uri.parse("${StringConstant.baseUrl}/user/$id"));
    var it = jsonDecode(response.body);
    print(it);
    data = User.fromJson(it);
    return data;
  }
}