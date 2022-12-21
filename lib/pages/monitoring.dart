import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:simoco_rc/constant/string_constant.dart';
import 'package:simoco_rc/providers/dashboard_service.dart';
//import 'package:simoco_rc/model/mqtt.dart';

import '../model/dashboard_model.dart';

class MonitoringPage extends StatefulWidget {
  const MonitoringPage({super.key});
  @override
  _MonitoringPageState createState() => _MonitoringPageState();
}

class _MonitoringPageState extends State<MonitoringPage> {
  static String? idProduct;
  List<dynamic> _dataTopic = [];

  SampleModel data = SampleModel();
  InfoModel valueData = InfoModel();

  Future<List> getTopic() async {
    //var baseUrl = StringConstant.baseUrl+"/monitoring";
    var response = await http.get(Uri.parse("${StringConstant.baseUrl}/monitoring"));
     //untuk melakukan request ke webservice
     if (response.statusCode==200){
      var listData = jsonDecode(response.body); //lalu kita decode hasil datanya
      setState(() {
        _dataTopic = listData; // dan kita set kedalam variable _dataTopic
      });
     }
    // print("data : $listData");
    print(_dataTopic);
    return _dataTopic;
  }

  getData() async{
    await DashboardService().getMqttByTopic().then((value){
      setState(() {
        data = value;
        valueData = data.value!;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getTopic(); //Ketika pertama kali membuka home screen makan method ini dijalankan untuk pertama kalinya juga
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      appBar: AppBar(title: const Text("Dropdown Menu Button JSON")),
      body: Column(
        children:<Widget>[
          Column(
             crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButton(
               isExpanded: true,
                hint: const Text("Select Province"),
                value: idProduct,
                items: _dataTopic.map((item) {
                  return DropdownMenuItem(
                    child: Text(item['topic']),
                    //value: item['topic'],
                    value: item['id'].toString(),
                  );
                }).toList(),
                onChanged: (value) {
                 setState(() {
                   idProduct = value;
                 });
                },
              ),
            ],
          ),
          Text(
            "Kamu memilih provinsi $idProduct",
            style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),

         idProduct != null ? Container(
            height: 400,
            child: FutureBuilder(
              future: getData(),
              builder: (context, snapshot){
              if (snapshot.hasData){
              //       return ListView.builder(
              //         itemBuilder: (context,index){
              //           return ListTile(

              //           );
              //         });
              } return const Text('No data found');
            }
            ),
          ): const Text('Select Topic First'),
        ],
      ),
    );
  }
}