

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simoco_rc/constant/string_constant.dart';
import 'package:simoco_rc/model/container_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:simoco_rc/model/mqtt_model.dart';
import 'package:simoco_rc/pages/detail_page.dart';
import 'package:simoco_rc/providers/dashboard_provider.dart';
import 'package:http/http.dart' as http;

// import 'package:simoco_rc/providers/DetailPage_provider.dart';
// import 'package:simoco_rc/screens/DetailPage_add.dart';

class ContainerCategory extends StatefulWidget {

   const ContainerCategory({super.key});

  @override
  State<ContainerCategory> createState() => _ContainerCategoryState();
}


class _ContainerCategoryState extends State<ContainerCategory> {

  String? name;
  String? count1;
  String? count2;
  List<ContainerModel> listContainer =[];
  //ContainerProvider cp = ContainerProvider();

  Widget _buildList() {
    return Scaffold(
      backgroundColor: Colors.transparent,
        body: FutureBuilder<List<Mqtt>>(
        future: DashboardCategoryProvider().getMqtt(),
        builder: (context, snapshot) {
          final data = snapshot.data;
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: data?.length,
              itemBuilder: (context, index) {
                final mqttData = data![index];
                return Card(
                  elevation: 8.0,
                  child: ListTile(
                    contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20.0),
                    leading: Container(
                      padding: const EdgeInsets.only(right: 12.0),
                      decoration: const BoxDecoration(
                          border: Border(
                              right: BorderSide(width: 1.0, color: Colors.black))),
                      child: const Icon(Icons.autorenew, color: Colors.black),
                    ),
                    title: Text(
                      mqttData.topic.toString(),
                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    ),

                    trailing:
                        const Icon(Icons.keyboard_arrow_right, color: Colors.black, size: 30.0),
                    onTap: () async {
                      SharedPreferences pref = await SharedPreferences.getInstance();
                      await pref.setString("id", mqttData.id.toString());
                       ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(mqttData.id.toString())));
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => const DetailPage()));
                    },
                  ),
                );
              });
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ));
  }


  void getCred() async {
    final mon = await http.get(Uri.parse('${StringConstant.baseUrl}/monitoring/hitung'));
    final con = await http.get(Uri.parse('${StringConstant.baseUrl}/container/hitung'));
    final body1 = json.decode(mon.body)['count'];
    final body2 = json.decode(con.body)['count'];
    //var count = body;

    count1 = body1.toString();
    count2 = body2.toString();
    //fetch shared preferences
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState((){
      name = pref.getString("name");
    });
  }

  @override
  void initState(){
    super.initState();
    getCred();
    // getContainer(); //Ketika pertama kali membuka home screen makan method ini dijalankan untuk pertama kalinya juga
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title:  const Text('Dashboard MQTT'),
      centerTitle:true,
      ),
      body: Container(
        height: 1000,
        decoration:  const BoxDecoration(color: Color(0xFF0D214F)),
        child: SafeArea(
          child: Padding(
            padding:  const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                 const SizedBox(
                    height: 10,
                  ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Hello, ${name}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  ),
                                ),
                            ],
                          ),
                          Container(
                            decoration:
                            BoxDecoration (
                              color: Colors.blue[600],
                              borderRadius: BorderRadius.circular(12)
                            ),
                            padding:  const EdgeInsets.all(12),
                            child: GestureDetector(
                              onTap: (){
                                Navigator.pushNamed(context, 'profiles');
                              },
                              child:  const Icon(
                              Icons.settings,
                              color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:  const [
                          Text(
                            'Monitoring Container',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                          ),
                        ),
                          Icon (
                            Icons.more_horiz,
                            color: Colors.white,
                          )
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Row(children: [
                    //Suhu Container
                    // Emoticonface(emoticonFace: '❄️',
                    // ),
                    Container(
                       padding: const EdgeInsets.all(12),
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(10),
                         color: Colors.white,
                       ),
                       child:
                       Icon(FontAwesomeIcons.boxArchive,
                       color: Colors.blue[300],
                       )
                     ),
                     const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        const Text(
                          'Active Container',
                          style: TextStyle(color: Colors.white,
                          fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${count1}',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                         )
                        ],
                      ),
                       const SizedBox(
                        width: 30,
                      ),
                      Container(
                       padding:  const EdgeInsets.all(12),
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(10),
                         color: Colors.white,
                       ),
                       child:
                       Icon(FontAwesomeIcons.boxOpen,
                       color: Colors.blue[300],
                       )
                     ),
                      const SizedBox(
                      width: 10,
                     ),
                      Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'All Container',
                          style: TextStyle(color: Colors.white,
                          fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${count2}',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                         )
                        ],
                      ),
                    ],
                  ),
                    ],
                  ),
                ),
                   const SizedBox(
                    height: 25,
                  ),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25)
                        ),
                        child: Container(
                          color: Colors.grey[200],
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Column(
                              children: [
                                Center(
                                  child: Column(
                                    children: const [
                                       SizedBox(
                                        height: 5,
                                      ),
                                      // Icon(Icons.expand_more),
                                       Icon(FontAwesomeIcons.ellipsis),
                                       SizedBox(
                                        height: 5,
                                      ),
                                       Text(
                                        'Choose Active Container',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17),
                                      ),
                                       SizedBox(
                                        height: 10,
                                      ),
                                      //list view card icon
                                      // Status AC

                                    ],
                                  ),
                                ),
                                Expanded(child: _buildList()),
                              ],
                            ),
                          ),
                        ),
                    )
                  ),
              ],
            ),
          ),
        ),
      )
    );
  }

}
