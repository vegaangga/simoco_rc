import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simoco_rc/pages/category_cdroppoint.dart';
import 'package:simoco_rc/pages/detail_droppoint.dart';
import 'package:simoco_rc/pages/droppoint_page.dart';
import 'package:simoco_rc/providers/kapal_provider.dart';
import 'package:simoco_rc/model/kapal_model.dart';
import 'package:simoco_rc/widgets/search_widget.dart';
import 'package:flutter/material.dart';

class KapalDroppoint extends StatefulWidget {
  const KapalDroppoint({super.key});

  @override
  KapalDroppointState createState() => KapalDroppointState();
}

class KapalDroppointState extends State<KapalDroppoint> {
  List<Kapal> kapals = [];
  String query = '';
  Timer? debouncer;

  @override
  void initState() {
    super.initState();

    init();
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  Future init() async {
    final kapals = await KapalApi.getKapal(query);

    setState(() => this.kapals = kapals);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("List Kapal"),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            const SizedBox(
              height: 15,
            ),
            buildSearch(),
            Expanded(
              child: ListView.builder(
                itemCount: kapals.length,
                itemBuilder: (context, index) {
                  final kapal = kapals[index];
                  return buildKapal(kapal);
                },
              ),
            ),
          ],
        ),
      );

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Container',
        onChanged: searchKapal,
      );

  Future searchKapal(String query) async => debounce(() async {
        final kapals = await KapalApi.getKapal(query);

        if (!mounted) return;

        setState(() {
          this.query = query;
          this.kapals = kapals;
        });
      });

  Widget buildKapal(Kapal kapal) => ListTile(
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 20.0),
        leading: Container(
          padding: const EdgeInsets.only(right: 12.0),
          decoration: const BoxDecoration(
              border: Border(
                  right: BorderSide(width: 1.0, color: Colors.black))),
          child: const Icon(Icons.content_paste_search_rounded, color: Colors.black),
        ),
        title: Text(
          kapal.imo!,
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      trailing:
            const Icon(Icons.keyboard_arrow_right, color: Colors.black, size: 30.0),
        onTap: () async {
          SharedPreferences pref = await SharedPreferences.getInstance();
          await pref.setString("idKapal", kapal.id.toString());
           ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(kapal.id.toString())));
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ContainerDroppoint()));
        },
      );
}