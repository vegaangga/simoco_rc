import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simoco_rc/pages/detail_droppoint.dart';
import 'package:simoco_rc/pages/droppoint_page.dart';
import 'package:simoco_rc/providers/container2_provider.dart';
import 'package:simoco_rc/model/container2_model.dart';
import 'package:simoco_rc/widgets/search_widget.dart';
import 'package:flutter/material.dart';

class ContainerDroppoint extends StatefulWidget {
  @override
  ContainerDroppointState createState() => ContainerDroppointState();
}

class ContainerDroppointState extends State<ContainerDroppoint> {
  List<Book> books = [];
  String query = '';
  Timer? debouncer;
  final BooksApi _get = BooksApi();

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
    final books = await _get.getContainer(query);

    setState(() => this.books = books);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("List Container"),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            const SizedBox(
              height: 15,
            ),
            Card(
              child: ListTile(
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20.0),
                  leading: Container(
                    padding: const EdgeInsets.only(right: 12.0),
                    decoration: const BoxDecoration(
                        border: Border(
                            right: BorderSide(width: 1.0, color: Colors.black))),
                    child: const Icon(Icons.content_paste_search_rounded, color: Colors.black),
                  ),
                  title: const Text(
                   "Show List Drop Point",
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                trailing:
                      const Icon(Icons.keyboard_arrow_right, color: Colors.black, size: 30.0),
                  onTap: () async {
                    ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text("Memunculkan Seluruh List Drop Point")));
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => const Droppoint()));
                  },
                ),
            ),
            buildSearch(),
            Expanded(
              child: ListView.builder(
                itemCount: books.length,
                itemBuilder: (context, index) {
                  final book = books[index];
                  return buildBook(book);
                },
              ),
            ),
          ],
        ),
      );

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Container',
        onChanged: searchBook,
      );

  Future searchBook(String query) async => debounce(() async {
        final books = await _get.getContainer(query);

        if (!mounted) return;

        setState(() {
          this.query = query;
          this.books = books;
        });
      });

  Widget buildBook(Book book) => ListTile(
        // title: Text(book.noContainer!),
        //subtitle: Text(book.kapasitas).toString(),
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
          book.noContainer!,
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      trailing:
            const Icon(Icons.keyboard_arrow_right, color: Colors.black, size: 30.0),
        onTap: () async {
          SharedPreferences pref = await SharedPreferences.getInstance();
          await pref.setString("idContainer", book.id.toString());
           ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(book.id.toString())));
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const DetailDroppoint()));
        },
      );
}