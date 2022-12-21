import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simoco_rc/constant/string_constant.dart';
import 'package:simoco_rc/model/province.dart';
import 'package:simoco_rc/pages/droppoint_page.dart';
import 'package:flutter/material.dart';
import 'package:simoco_rc/widgets/themes.dart';


class QrCode extends StatefulWidget {
  const QrCode({super.key});

  @override
  _QrCodeState createState() => _QrCodeState();
}

class _QrCodeState extends State<QrCode> {
  //get snackbarKey => null;
  final snackbarKey = GlobalKey<ScaffoldState>();
  //KOMENTAR-3: DEFINE VARIABLE
  final TextEditingController _idTransaksi = TextEditingController();
  final TextEditingController _keterangan = TextEditingController();

  String? kodePelabuhan;

  bool _isLoading = false;
  FocusNode pelabuhanNode = FocusNode();
  FocusNode keteranganNode = FocusNode();
  String _scanBarcode = 'Unknown';

  Future<void> submit(BuildContext context) async {
    //  SharedPreferences pref = await SharedPreferences.getInstance();
    //   kodePelabuhan = await pref.getString("kodePelabuhan");
    // setState(() {
    //   _idTransaksi.text = _scanBarcode;
    // });
    if(_idTransaksi.text.isNotEmpty &&_keterangan.text.isNotEmpty){
      var response = await http.post(Uri.parse("${StringConstant.baseUrl}/droppoint"),
          body: ({
            "id_transaksi" : _idTransaksi.text,
            "pelabuhan" : kodePelabuhan,
            "keterangan" : _keterangan.text
          }));
          ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Berhasil Insert Data")));
        Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context)=>const Droppoint()),
          (route) => false);
    } else{
      ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Blank Value found")));
    }
}
Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
      _idTransaksi.text = _scanBarcode;
    });
  }
  Widget _buildIdTransaksi() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'ID Transaksi',
          style: kLabelStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          //color: Colors.white,
          alignment: Alignment.centerLeft,
          decoration: kBoxwhite,
          height: 60.0,
          child: TextField(
            controller: _idTransaksi,
            // obscureText: passwordVisible,
            style: const TextStyle(
              // color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 14.0),
              prefixIcon: const Icon(
                Icons.add_to_photos_sharp,
                color: Colors.black,
              ),
              hintText: 'Enter ID Transaksi',
              hintStyle: kHintTextBlack,

            ),
          ),
        ),
      ],
    );
  }

  Widget _buildKeterangan() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Note',
          style: kLabelStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxwhite,
          height: 60.0,
          child: TextField(
            controller: _keterangan,
            style: const TextStyle(
              // color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 14.0),
              prefixIcon: const Icon(
                Icons.add_comment_rounded,
                color: Colors.black,
              ),
              hintText: 'Enter Note',
              hintStyle: kHintTextBlack,

            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
        // style: ButtonStyle(
        //   backgroundColor: MaterialStateProperty.all(Colors.white),
        // ),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.blue,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
        ),
        onPressed: (){
          submit(context);
        },
        child: const Text(
          'SUBMIT',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  void initState(){
    super.initState();
    getCred();
  }

  void getCred() async {
    //fetch shared preferences
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState((){
      _scanBarcode = pref.getString("_scanBarcode")!;
      _idTransaksi.text = _scanBarcode;
    });
  }


  @override

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Add Drop Point"),
        centerTitle: true,
      ),
      body: Container(
            decoration: const BoxDecoration(color: Color(0xFF0D214F)),
            child:
            // Greetings row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: SafeArea(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SizedBox(
                          height: 50,
                          child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/QR_code_for_QRpedia.png',
                                )
                              ),
                            ), //BoxDecoration
                          ),
                        ),
                      ),
                    ), //Center
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                    decoration: BoxDecoration(
                      color: Colors.blue[600],
                      borderRadius: BorderRadius.circular(12)
                      ),
                      padding: const EdgeInsets.all(12),
                      child: ElevatedButton(
                              onPressed: () => scanQR(),
                              //onPressed: () {  },
                              child: const Text('Start QR scan')),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Scan result : $_scanBarcode\n',
                            style: const TextStyle(fontSize: 20, color: Colors.white)),
                     Column(
                       children: [
                        _buildIdTransaksi(),
                        const SizedBox(height: 10.0),
                          Form(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Pelabuhan',
                                  style: kLabelStyle,
                                ),
                                const SizedBox(height: 10.0),
                                Container(
                                  color: Colors.white,
                                  child: DropdownSearch<Province>(
                                    mode: Mode.DIALOG,
                                    showClearButton: true,
                                    showSearchBox: true,
                                    //onChanged: (value) => kodePel = value?.kodePelabuhan,
                                    // onChanged: (value) => print(value?.toJson()),
                                    onChanged: (value){
                                      setState(() {
                                        kodePelabuhan= value?.kodePelabuhan;
                                        // SharedPreferences pref = await SharedPreferences.getInstance();
                                        // await pref.setString("kodePelabuhan", kodePelabuhan!);
                                    });
                                    },
                                    //validator: (value) => value == null ? 'field required' : null,
                                    dropdownBuilder: (context, selectedItem) =>
                                        Text(selectedItem?.namaPelabuhan ?? "Silahkan memilih pelabuhan"),
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
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          _buildKeterangan(),
                          _buildLoginBtn(),
                       ],
                     ),
                     const SizedBox(
                      height: 20,
                    ),
                    //  Row(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //    children: [
                    //      ElevatedButton(
                    //       onPressed: () => submit(context),
                    //       child: const Text('Save')),
                    //    ],
                    //  ),

                    // card info

                  ]
                  ),
              )
              )
            ),
    );
  }
}

