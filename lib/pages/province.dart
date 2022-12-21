import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:http/http.dart' as http;
import 'package:simoco_rc/constant/string_constant.dart';
import 'package:simoco_rc/model/province.dart';
import 'package:simoco_rc/model/city.dart';


class ProvincePage extends StatelessWidget {
  String? idProv;

  final String apiKey =
      "f8349337f4527932f87e84f3800d957f03dc7725053118463a848d349f3607fa";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DROPDOWN API'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          DropdownSearch<Province>(
            mode: Mode.DIALOG,
            showClearButton: true,
            showSearchBox: true,
            onChanged: (value) => idProv = value?.kodePelabuhan,
            // onChanged: (value) => print(value?.toJson()),
            dropdownBuilder: (context, selectedItem) =>
                Text(selectedItem?.namaPelabuhan ?? "Silahkan memilih provinsi"),
            popupItemBuilder: (context, item, isSelected) => ListTile(
              title: Text(item.namaPelabuhan),
            ),
            onFind: (text) async {
              var response = await http.get(Uri.parse(
                  StringConstant.baseUrl+"/pelabuhan"));
              if (response.statusCode != 200) {
                return [];
              }
              List allProvince =
                  (json.decode(response.body) as Map<String, dynamic>)['data'];
              List<Province> allNameProvince = [];

              allProvince.forEach((element) {
                allNameProvince
                    .add(Province(kodePelabuhan: element['kode_pelabuhan'], namaPelabuhan: element['nama_pelabuhan']));
              });
              return allNameProvince;
            },
          ),
          SizedBox(height: 20),
          DropdownSearch<City>(
            mode: Mode.DIALOG,
            showClearButton: true,
            showSearchBox: true,
            onChanged: (value) => print(value?.toJson()),
            dropdownBuilder: (context, selectedItem) =>
                Text(selectedItem?.name ?? "Silahkan memilih provinsi"),
            popupItemBuilder: (context, item, isSelected) => ListTile(
              title: Text(item.name),
            ),
            onFind: (text) async {
              print(idProv);
              var response = await http.get(Uri.parse(
                  "https://api.binderbyte.com/wilayah/kabupaten?api_key=$apiKey&id_provinsi=$idProv"));
              if (response.statusCode != 200) {
                return [];
              }
              List allProvince =
                  (json.decode(response.body) as Map<String, dynamic>)['value'];
              List<City> allNameProvince = [];

              allProvince.forEach((element) {
                allNameProvince.add(City(
                    id: element["id"],
                    idProvinsi: element["id_provinsi"],
                    name: element["name"]));
              });
              return allNameProvince;
            },
          ),
        ],
      ),
    );
  }
}