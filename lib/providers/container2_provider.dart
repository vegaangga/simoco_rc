import 'dart:convert';

import 'package:simoco_rc/constant/string_constant.dart';
import 'package:simoco_rc/model/container2_model.dart';
import 'package:http/http.dart' as http;

class BooksApi {
  static Future<List<Book>> getContainer(String query) async {
    final response = await http.get(Uri.parse("${StringConstant.baseUrl}/droppoint"));

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