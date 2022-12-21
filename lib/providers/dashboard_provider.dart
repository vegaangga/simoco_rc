import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simoco_rc/constant/string_constant.dart';

import '../model/mqtt_model.dart';

class DashboardCategoryProvider{

  Future<List<Mqtt>> getMqtt() async{

    final req = await http.get(Uri.parse('${StringConstant.baseUrl}/monitoring'));
    final body = req.body;

    if(req.statusCode == 200){
      final mqtt = mqttFromJson(body);

      print(mqtt);
       return mqtt;
    }
   else{
     final body = req.body;
     final error = mqttFromJson(body);
     print(error);
     return error;
   }
  }
}