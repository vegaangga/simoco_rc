import 'package:simoco_rc/model/dashboard_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:simoco_rc/constant/string_constant.dart';

class ServiceClass{
  int? _valTopic;
    //a = _HomeScreenState._valTopic;
    //String _valTopic = obj.getValue();
    Future<SampleModel> getMqttByTopic() async{
    SampleModel data;
    var baseUrl = "${StringConstant.baseUrl}/monitoring/topicid=$_valTopic";
    var response = await http.get(Uri.parse(baseUrl));
    var it = jsonDecode(response.body);
    print(it);
    data = SampleModel.fromJson(it);
    return data;
  }

}