// ignore: unnecessary_import
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simoco_rc/constant/string_constant.dart';
import 'package:simoco_rc/pages/category_container.dart';
import 'package:flutter/material.dart';
import 'package:simoco_rc/pages/profile_page.dart';
import 'package:simoco_rc/widgets/themes.dart';


class ChangeTelp_page extends StatefulWidget {
  const ChangeTelp_page({super.key});

  @override
  _ChangeTelp_pageState createState() => _ChangeTelp_pageState();
}

class _ChangeTelp_pageState extends State<ChangeTelp_page> {
  int currentTab = 0;
  Widget currentScreen = const ContainerCategory();
  //get snackbarKey => null;
  final snackbarKey = GlobalKey<ScaffoldState>();
  //KOMENTAR-3: DEFINE VARIABLE
  final TextEditingController _telp = TextEditingController();

  bool _isLoading = false;
  FocusNode pelabuhanNode = FocusNode();
  FocusNode keteranganNode = FocusNode();
  String? id;

  Future<void> submit(BuildContext context) async {
    if(_telp.text.isNotEmpty){
      var response = await http.put(Uri.parse("${StringConstant.baseUrl}/user/telp/$id"),
          body: ({
            "no_telp" : _telp.text,
          }));
        if(response.statusCode==200){
          ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Berhasil Update No Telephone")));
        // Navigator.of(context).pushAndRemoveUntil(
        // MaterialPageRoute(builder: (context)=>const ProfilePage()),
        //   (route) => false);
          Navigator.pushNamed(context, 'navbar').then((_) {
        // This block runs when you have returned back to the 1st Page from 2nd.
          setState(() {
            currentScreen = const ProfilePage();
            currentTab = 3;
          });
        });
        } else{
          ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Failed Update")));
        // Navigator.of(context).pushAndRemoveUntil(
        // MaterialPageRoute(builder: (context)=>const Navbar()),
        //   (route) => false);
        Navigator.pushNamed(context, 'navbar').then((_) {
        // This block runs when you have returned back to the 1st Page from 2nd.
          setState(() {
            currentScreen = const ProfilePage();
            currentTab = 3;
          });
        });
        }

    } else{
      ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Blank Value found")));
    }
}
  Widget _buildIdTransaksi() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Nomor Telephone',
          style: kLabelStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          //color: Colors.white,
          alignment: Alignment.centerLeft,
          decoration: kBoxwhite,
          height: 60.0,
          child: TextField(
            controller: _telp,
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
              hintText: 'Enter New Telephone',
              hintStyle: kHintTextBlack,

            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitbutton() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
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
        child: _isLoading
        ? SizedBox(
            height: 25,
            width: 25,
            child: CircularProgressIndicator(),
          ):
        const Text(
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

  getCred() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
      id = pref.getString("iduser");
  }

  void initState(){
    super.initState();
    getCred();
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Edit Telephone"),
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

                    const SizedBox(
                      height: 10,
                    ),

                     Column(
                       children: [
                        _buildIdTransaksi(),
                        const SizedBox(height: 10.0),
                          _buildSubmitbutton(),
                       ],
                     ),
                     const SizedBox(
                      height: 20,
                    ),

                  ]
                  ),
              )
              )
            ),
    );
  }
}

