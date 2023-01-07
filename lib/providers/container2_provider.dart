import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:simoco_rc/constant/string_constant.dart';
import 'package:simoco_rc/model/container2_model.dart';
import 'package:http/http.dart' as http;

class BooksApi {

  String? id;
  Future<List<Book>> getContainer(String query) async {
     SharedPreferences pref = await SharedPreferences.getInstance();
      id = pref.getString("idKapal");
    final response = await http.get(Uri.parse("${StringConstant.baseUrl}/kapal/$id/container"));

    if (response.statusCode == 200) {
      final List books = json.decode(response.body);

      return books.map((json) => Book.fromJson(json)).where((book) {
        //final titleLower = book.title.toLowerCase();
        final containerLower = book.noContainer?.toLowerCase();
        String searchLower = query.toLowerCase();

        return containerLower!.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}