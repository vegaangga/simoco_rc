import 'dart:convert';

import 'package:simoco_rc/constant/string_constant.dart';
import 'package:simoco_rc/model/kapal_model.dart';
import 'package:http/http.dart' as http;

class KapalApi {
  static Future<List<Kapal>> getKapal(String query) async {
    final response = await http.get(Uri.parse("${StringConstant.baseUrl}/kapal"));

    if (response.statusCode == 200) {
      final List kapals = json.decode(response.body);

      return kapals.map((json) => Kapal.fromJson(json)).where((kapal) {
        //final titleLower = book.title.toLowerCase();
        final containerLower = kapal.imo?.toLowerCase();
        String searchLower = query.toLowerCase();

        return containerLower!.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}