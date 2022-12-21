// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:http/http.dart' as http;
// import 'package:simoco_rc/model/pelabuhan_model.dart';
// // import '../models/city.dart';

// class HomePage extends StatefulWidget {

//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   String? idProv;

//   final String apiKey =
//       "f8349337f4527932f87e84f3800d957f03dc7725053118463a848d349f3607fa";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('DROPDOWN API'),
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(20),
//         children: [
//           DropdownSearch<Pelabuhan>(
//             mode: Mode.DIALOG,
//             showClearButton: true,
//             showSearchBox: true,
//             onChanged: (value) => idProv = value?.id,
//             // onChanged: (value) => print(value?.toJson()),
//             dropdownBuilder: (context, selectedItem) =>
//                 Text(selectedItem?.name ?? "Silahkan memilih provinsi"),
//             popupItemBuilder: (context, item, isSelected) => ListTile(
//               title: Text(item.name),
//             ),
//             onFind: (text) async {
//               var response = await http.get(Uri.parse(
//                   "https://api.binderbyte.com/wilayah/provinsi?api_key=$apiKey"));
//               if (response.statusCode != 200) {
//                 return [];
//               }
//               List allPelabuhan =
//                   (json.decode(response.body) as Map<String, dynamic>)['value'];
//               List<Pelabuhan> allNamePelabuhan = [];

//               for (var element in allPelabuhan) {
//                 allNamePelabuhan
//                     .add(Pelabuhan(id: element['id'], name: element['name']));
//               }
//               return allNamePelabuhan;
//             },
//           ),
//           const SizedBox(height: 20),
//           DropdownSearch<City>(
//             mode: Mode.DIALOG,
//             showClearButton: true,
//             showSearchBox: true,
//             onChanged: (value) => print(value?.toJson()),
//             dropdownBuilder: (context, selectedItem) =>
//                 Text(selectedItem?.name ?? "Silahkan memilih provinsi"),
//             popupItemBuilder: (context, item, isSelected) => ListTile(
//               title: Text(item.name),
//             ),
//             onFind: (text) async {
//               print(idProv);
//               var response = await http.get(Uri.parse(
//                   "https://api.binderbyte.com/wilayah/kabupaten?api_key=$apiKey&id_provinsi=$idProv"));
//               if (response.statusCode != 200) {
//                 return [];
//               }
//               List allPelabuhan =
//                   (json.decode(response.body) as Map<String, dynamic>)['value'];
//               List<City> allNamePelabuhan = [];

//               allPelabuhan.forEach((element) {
//                 allNamePelabuhan.add(City(
//                     id: element["id"],
//                     idProvinsi: element["id_provinsi"],
//                     name: element["name"]));
//               });
//               return allNamePelabuhan;
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }