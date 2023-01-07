import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simoco_rc/constant/string_constant.dart';
import 'package:simoco_rc/pages/category_container.dart';
import 'package:flutter/material.dart';
import 'package:simoco_rc/pages/profile_page.dart';
import 'package:simoco_rc/widgets/themes.dart';


class ChangePassword_page extends StatefulWidget {
  const ChangePassword_page({super.key});

  @override
  _ChangePassword_pageState createState() => _ChangePassword_pageState();
}

class _ChangePassword_pageState extends State<ChangePassword_page> {
  int currentTab = 0;
  Widget currentScreen = const ContainerCategory();
  //get snackbarKey => null;
  final snackbarKey = GlobalKey<ScaffoldState>();
  //KOMENTAR-3: DEFINE VARIABLE
   final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  bool _isLoading = false;
  FocusNode pelabuhanNode = FocusNode();
  FocusNode keteranganNode = FocusNode();
  String _password = '';
  String _confirmPassword = '';

  final _formKey = GlobalKey<FormState>();
  String? id;

  Future<void> submit(BuildContext context) async {
    if(_pass.text.isNotEmpty && _confirmPass.text.isNotEmpty){
      var response = await http.put(Uri.parse("${StringConstant.baseUrl}/user/password/$id"),
          body: ({
            "password" : _pass.text,
            "password_confirmation" : _confirmPass.text,
          }));
        if(response.statusCode==200){
          ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Berhasil Update Password")));
        Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context)=>const ProfilePage()),
          (route) => false);
        } else{
          ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Gagal Update Email")));
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
Widget _buildPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: kLabelStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          //color: Colors.white,
          alignment: Alignment.centerLeft,
          decoration: kBoxwhite,
          height: 60.0,
          child: TextFormField(
            validator: (val){
               if(val!.isEmpty) {
                 return 'Empty';
               }
               return null;
               },
            controller: _pass,
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
              hintText: 'Enter New Password',
              hintStyle: kHintTextBlack,

            ),
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmpass() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Confirm Password',
          style: kLabelStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          //color: Colors.white,
          alignment: Alignment.centerLeft,
          decoration: kBoxwhite,
          height: 60.0,
          child: TextFormField(
            validator: (val){
            if(val!.isEmpty)
                  return 'Empty';
            if(val != _pass.text)
                  return 'Not Match';
            return null;
            },
            controller: _confirmPass,
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
              hintText: 'Confirm Password',
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
          if (_formKey.currentState!.validate()) {
          // If the form is valid, display a snackbar. In the real world,
          // you'd often call a server or save the information in a database.
          submit(context);
        }
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
    // return Scaffold(
    //   //resizeToAvoidBottomInset: false,
    //   appBar: AppBar(
    //     title: Text("Edit Password User"),
    //     centerTitle: true,
    //   ),
    //   body: Container(
    //     height: 400,
    //         decoration: const BoxDecoration(color: Color(0xFF0D214F)),
    //         child:
    //         SafeArea(
    //           child: Form(
    //             key: _formKey,
    //             child:
    //                Column(
    //                 children: [
    //                 _buildPassword(),
    //                 SizedBox(height: 10,),
    //                 _buildConfirmpass(),
    //                   const SizedBox(height: 10.0),
    //                  _buildSubmitbutton(),
    //                   const SizedBox(
    //                     height: 20,)
    //                 ],
    //                     ),
    //               ),
    //             ),
    //         )
    //         );
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                       _buildPassword(),
                       const SizedBox(height: 10.0),
                       _buildConfirmpass(),
                         _buildSubmitbutton(),
                       const SizedBox(
                        height: 20,
                      ),

                    ]
                    ),
                ),
              )
              )
            ),
    );
  }
}

