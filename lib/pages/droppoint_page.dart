import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simoco_rc/constant/string_constant.dart';
import 'package:simoco_rc/pages/droppoint_update.dart';
import 'package:simoco_rc/providers/droppoint_provider.dart';
import 'package:simoco_rc/pages/droppoint_add.dart';

class Droppoint extends StatefulWidget {

  const Droppoint({super.key});

  @override
  State<Droppoint> createState() => _DroppointState();
}

class _DroppointState extends State<Droppoint> {
  //String url = 'https://2d43-103-174-113-10.ap.ngrok.io/api/droppoint';
  //192.168.1.18 ->ip wifi kos
  //192.168.163.39 -> iphotspot hp
  //http://10.0.2.2:8000 -> ip android studio
  //https://97f7-103-174-113-10.ap.ngrok.io/
  late BuildContext context;
  // late DroppointProvider apiService;

  Future getDroppoint() async{
    var response = await http.get(Uri.parse(StringConstant.baseUrl+"/alldroppoint"));
    //print(json.decode(response.body));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    getDroppoint();
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Seluruh Droppoint'),
      ),
      body:
      RefreshIndicator(
          //ADAPUN FUNGSI YANG DIJALANKAN ADALAH getEmployee() DARI EMPLOYEE_PROVIDER
          onRefresh: () =>
              Provider.of<DroppointProvider>(context, listen: false).getDroppoint(),
          color: Colors.red,
          child: Container(
            margin: const EdgeInsets.all(10),
            //KETIKA PAGE INI DIAKSES MAKA AKAN MEMINTA DATA KE API
            child: FutureBuilder(
              //DENGAN MENJALANKAN FUNGSI YANG SAMA
              future: Provider.of<DroppointProvider>(context, listen: false)
                  .getDroppoint(),
              builder: (context, snapshot) {
                //JIKA PROSES REQUEST MASIH BERLANGSUNG
                if (snapshot.connectionState == ConnectionState.waiting) {
                  //MAKA KITA TAMPILKAN INDIKATOR LOADING
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Consumer<DroppointProvider>(
                  builder: (context, data, _) {
                    //KEMUDIAN LOOPING DATANYA DENGNA LISTVIEW BUILDER
                    return ListView.builder(
                      //ADAPUN DATA YANG DIGUNAKAN ADALAH REAL DATA DARI GETTER dataEmployee
                      itemCount: data.dataDroppoint.length,
                      itemBuilder: (context, i) {
                        return Card(
                          elevation: 8,
                          child: ListTile(
                            title: Text(
                            'ID Transaksi: ${data.dataDroppoint[i].idTransaksi.toString()}',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            subtitle:
                                Text('Posisi Barang Sekarang: ${data.dataDroppoint[i].namaPelabuhan}'),
                            trailing:
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                  ),
                                  onPressed: () {
                                    showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text("Warning"),
                                        content: Text(
                                            "Are you sure want to delete Data Drop point Id Transaksi: ${data.dataDroppoint[i].idTransaksi}?"),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text("Yes"),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              DroppointProvider()
                                                  .deleteData(data.dataDroppoint[i].id as int)
                                                  .then((isSuccess) {
                                                if (isSuccess) {
                                                  setState(() {});
                                                  ScaffoldMessenger.of(this.context)
                                                      .showSnackBar(const SnackBar(
                                                          content: Text(
                                                              "Delete data success")));
                                                } else {
                                                  ScaffoldMessenger.of(this.context)
                                                      .showSnackBar(const SnackBar(
                                                          content: Text(
                                                              "Delete data failed")));
                                                }
                                              });
                                            },
                                          ),
                                          TextButton(
                                            child: const Text("No"),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          )
                                        ],
                                      );
                                    });
                                  },
                                  child: const Text(
                                    "Delete",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                            onTap: () async {
                              // ScaffoldMessenger.of(context)
                              // .showSnackBar(const SnackBar(content: Text("Kamu Memilih ID:")));
                              SharedPreferences pref = await SharedPreferences.getInstance();
                              await pref.setString("idDroppoint", data.dataDroppoint[i].id.toString());
                              ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text(data.dataDroppoint[i].idTransaksi.toString())));
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (context) => const DroppointUpdate()));
                            },
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ),
          floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.pink,
          child: const Text('+'),
          onPressed: () {
            Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const DroppointAdd()));
          },
        ),
      );
  }
}
