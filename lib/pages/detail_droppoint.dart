import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simoco_rc/model/listdroppoint_model.dart';
import 'package:simoco_rc/pages/droppoint_update.dart';
import 'package:simoco_rc/providers/droppoint_provider.dart';
import 'package:simoco_rc/providers/listdroppoint_provider.dart';

class DetailDroppoint extends StatefulWidget {
  const DetailDroppoint({super.key});

  @override
  State<DetailDroppoint> createState() => _DetailDroppointState();
}

class _DetailDroppointState extends State<DetailDroppoint> {
  List<listDroppointModel> listContainer =[];

  Widget _buildList() {
    return Scaffold(
      backgroundColor: Colors.transparent,
        body: FutureBuilder<List<listDroppointModel>>(
        future: ListDroppointProvider().getDroppoint(),
        builder: (context, snapshot) {
          final data = snapshot.data;
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: data?.length,
              itemBuilder: (context, index) {
                final droppoint = data![index];
                //List droppoint = data![index] as List<Mqtt>;
                return ListTile(
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20.0),
                  leading: Container(
                    padding: const EdgeInsets.only(right: 12.0),
                    decoration: const BoxDecoration(
                        border: Border(
                            right: BorderSide(width: 1.0, color: Colors.black))),
                    child: const Icon(Icons.autorenew, color: Colors.black),
                  ),
                  title: Text( "Posisi: ${droppoint.pelabuhanSekarang}",
                    style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  ),

                  subtitle: Text( "Tujuan: ${droppoint.tujuanPelabuhan}",
                  ),
                  trailing:
                      // const Icon(Icons.keyboard_arrow_right, color: Colors.black, size: 30.0),
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
                                            "Are you sure want to delete Data Drop point Id Transaksi: ${droppoint.droppointId}?"),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text("Yes"),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              DroppointProvider()
                                                  .deleteData(droppoint.droppointId as int)
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
                              await pref.setString("idDroppoint", droppoint.droppointId.toString());
                              ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text(droppoint.transaksiId.toString())));
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (context) => const DroppointUpdate()));
                            },
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("List Drop Point"),
          centerTitle: true,
        ),
      body: Column(
          children: <Widget>[
            Expanded(child: _buildList()),
          ],
        ),
    );
  }
}