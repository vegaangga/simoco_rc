import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:simoco_rc/providers/DashboardPage_provider.dart';
// import 'package:simoco_rc/screens/DashboardPage_add.dart';

class DashboardPage extends StatefulWidget {

  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String url = 'https://2d43-103-174-113-10.ap.ngrok.io/api/DashboardPage';
  //192.168.1.18 ->ip wifi kos
  //192.168.163.39 -> iphotspot hp
  //http://10.0.2.2:8000 -> ip android studio
  //https://97f7-103-174-113-10.ap.ngrok.io/

  Future getDashboardPage() async{
    var response = await http.get(Uri.parse(url));
    //print(json.decode(response.body));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    getDashboardPage();
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard MQTT')),
      body: const Center(child: Text("JSON Dinamis"),

      )
    );
  }
}
