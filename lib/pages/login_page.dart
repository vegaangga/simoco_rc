import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simoco_rc/constant/string_constant.dart';
import 'package:simoco_rc/widgets/navbar.dart';
import 'package:simoco_rc/widgets/themes.dart';
import 'package:http/http.dart' as http;

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
  bool passwordVisible = true;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  void showPassword(){
    setState((){
      passwordVisible = !passwordVisible;
    });
  }



  void login() async{
    if(passwordController.text.isNotEmpty && emailController.text.isNotEmpty){
      var response = await http.post(Uri.parse("${StringConstant.auth}/login"),
          body: ({
            "email" : emailController.text,
            "password" : passwordController.text
          }));

          if(response.statusCode==200){
            final body = json.decode(response.body);
            var res = json.decode(response.body)['data'];
            if (res['user']['role'] != 'Operator'){
              ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Pleas Sign In with Operator Credential")));
              logout();
            } else{
              //print("Login Token: "+ body["access_token"]);
            //  ScaffoldMessenger.of(context)
            //   .showSnackBar(SnackBar(content: Text("Token: ${body['access_token']}"),));
              // ScaffoldMessenger.of(context)
              // .showSnackBar(SnackBar(content: Text("Token: ${res['user']['id'].toString()}"),));
              //setName(res['name']);
                 SharedPreferences pref = await SharedPreferences.getInstance();
                  await pref.setString("login", body['access_token']);
              pageRout(body['access_token'],res['user']['name'],res['user']['id'].toString());
            }
          } else{
            ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Invalid Credentials")));
          }
    } else{
      ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Blank Value found")));
    }
  }

  // void setName(String name) async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   await pref.setString("name", name);
  // }

  void logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
    // var response = await http.post(Uri.parse("${StringConstant.auth}/logout"));
    // print(response);
  }

  void checkLogin() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? val = pref.getString("login");
    if (val != null){
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context)=>const Navbar()),
          (route) => false);
    }
  }

  void pageRout(String accessToken, String name, String id) async{
    //Store Token
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("access_token", accessToken);
    await pref.setString("name", name);
    await pref.setString("iduser", id);

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context)=>const Navbar()),
          (route) => false);
  }

  //Widgets
  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Email',
          style: kLabelStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Enter your Email',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Password',
          style: kLabelStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: passwordController,
            obscureText: passwordVisible,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 14.0),
              prefixIcon: const Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Enter your Password',
              hintStyle: kHintTextStyle,
              suffixIcon: IconButton(
                  onPressed: showPassword,
                  icon: Icon(passwordVisible
                      ? Icons.visibility_off
                      : Icons.visibility),
                  color: Colors.white,
                ),
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
          login();
        },
        child: const Text(
          'LOGIN',
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

  @override
  void initState(){
    super.initState();
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF73AEF5),
                      Color(0xFF61A4F1),
                      Color(0xFF478DE0),
                      Color(0xFF398AE5),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 120.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset('assets/images/seamoco_rc_circle.png',
                      height: 250,
                      width: 250,
                      ),
                      const Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      _buildEmailTF(),
                      const SizedBox(
                        height: 30.0,
                      ),
                      _buildPasswordTF(),
                      _buildLoginBtn(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}