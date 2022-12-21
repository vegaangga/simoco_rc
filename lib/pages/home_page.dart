import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? access_token;
  String? name;
  final baseUrl="https://8124-125-164-232-199.ap.ngrok.io";
  @override
  void initState(){
    super.initState();
    getCred();
  }

  void getCred() async {
    //fetch shared preferences
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState((){
      access_token = pref.getString("access_token");
      name = pref.getString("name");
    });
  }

  void logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                const Text("Welcome user"),
                const SizedBox(height: 15,),
                Text("Name: ${name}"),
                Text("Ur Access Token: ${access_token}"),
                OutlinedButton.icon(
                  onPressed: () async{
                    SharedPreferences pref = await SharedPreferences.getInstance();
                    await pref.clear();
                      Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context)=>const HomePage()),
                        (route) => false);
                  },
                  icon: const Icon(Icons.login),
                  label: const Text("Logout"),
                )
              ],
            ))),
      ),
    );
  }
}