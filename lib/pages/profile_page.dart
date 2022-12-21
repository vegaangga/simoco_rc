import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simoco_rc/constant/string_constant.dart';
import 'package:simoco_rc/model/user_model.dart';
import 'package:simoco_rc/pages/login_page.dart';
import 'package:simoco_rc/providers/user_provider.dart';
import 'package:flutter_initicon/flutter_initicon.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? access_token;
  String? name;
  String? id;

  User data = User();

  getData() async{
    await UserProvider().getUser().then((value) async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      setState(() {
        access_token = pref.getString("access_token");
        data = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getData(); //Ketika pertama kali membuka home screen makan method ini dijalankan untuk pertama kalinya juga
  }

  void logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context)=>const LoginPage()),
          (route) => false);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Drop Point'),
      centerTitle: true,
      ),
      // backgroundColor: Colors.blue[800],
      // bottomNavigationBar: BottomNavigation(),
      body: SingleChildScrollView(
        child: Container(
          height: 700,
          decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF73AEF5),
                        Color(0xFF61A4F1),
                        Color(0xFF478DE0),
                        Color.fromARGB(255, 15, 54, 147),
                      ],
                      stops: [0.1, 0.4, 0.7, 0.9],
                    ),
                  ),
          child: SafeArea(
            child: Column(children: [
              const SizedBox(
                height: 10,
              ),
              //
              // Profiles row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  children: [
                    Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          // CircleAvatar(
                          //   backgroundImage: NetworkImage('https://www.woolha.com/media/2020/03/eevee.png'),
                          //   radius: 50,
                          // ),
                          SizedBox(
                            height: 15,
                          ),
                          Initicon(
                            text: '${data.name}',
                            backgroundColor: Colors.amber,
                            size: 70,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('${data.name}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                          SizedBox(
                            height: 5,
                          ),
                          Text('${data.email}',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400
                          ),)
                          // Email
                        ],
                      ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    Row(children: const [
                      Text('Ubah Data Akun',
                      style: TextStyle(color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                      ),
                    ],),
                    const Divider(
                          thickness: 2,
                          color: Colors.white,
                        ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                          onTap: (){
                          Navigator.pushNamed(context, 'changeEmail');
                        },
                      child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)
                        ),
                        child:
                        Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Row(
                          children: [
                            const Icon(Icons.email,
                                color: Colors.yellow,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                //Title
                                Text(
                                  'Email',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  ),
                                ],
                             ),
                            ],
                          ),
                          const Icon(Icons.chevron_right_outlined),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  GestureDetector(
                     onTap: (){
                          Navigator.pushNamed(context, 'changePhone');
                        },
                      child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)
                        ),
                        child:
                        Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Row(
                          children: [
                            const Icon(Icons.phone_android,
                                color: Colors.yellow,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                //Title
                                Text(
                                  'Nomor HP',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  ),
                                ],
                             ),
                            ],
                          ),
                          const Icon(Icons.chevron_right_outlined),
                          ],
                        ),
                      ),
                    ),
                     const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                         onTap: (){
                          Navigator.pushNamed(context, 'changePassword');
                        },
                        child: Container(
                         padding: const EdgeInsets.all(15),
                         decoration: BoxDecoration(
                           color: Colors.white,
                           borderRadius: BorderRadius.circular(15)
                           ),
                           child:
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Row(
                                 children: [
                                   const Icon(FontAwesomeIcons.lock,
                                   color: Colors.yellow,
                                   ),
                                   const SizedBox(
                                     width: 15,
                                   ),
                                   Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: const [
                                       //Title
                                       Text(
                                         'Kata Sandi',
                                         style: TextStyle(
                                           fontWeight: FontWeight.bold,
                                         ),
                                         ),
                                     ],
                                   ),
                                 ],
                               ),
                               const Icon(Icons.chevron_right),
                             ],
                           ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      Row(children: const [
                        Text('Log Out',
                        style: TextStyle(color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                        ),
                      ],),
                      const Divider(
                        thickness: 2,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                         onTap: (){
                          // Navigator.pushNamed(context, 'login');
                          logout();
                        },
                        child: Container(
                         padding: const EdgeInsets.all(15),
                         decoration: BoxDecoration(
                           color: Colors.white,
                           borderRadius: BorderRadius.circular(15)
                           ),
                           child:
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Row(
                                 children: [
                                  const Icon(FontAwesomeIcons.arrowRightFromBracket,
                                 color: Colors.yellow,
                                   ),
                                   const SizedBox(
                                     width: 15,
                                   ),
                                   Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: const [
                                       //Title
                                       Text(
                                         'Log Out',
                                         style: TextStyle(
                                           fontWeight: FontWeight.bold,
                                         ),
                                         ),
                                     ],
                                   ),
                                 ],
                               ),
                               const Icon(Icons.chevron_right),
                             ],
                           ),
                        ),
                      ),
                      // Logout

                      const SizedBox(height: 50,),
                      const Text(
                        'Versi Aplikasi',
                        style: TextStyle(color: Colors.white)

                      ),
                      const Text(
                        style: TextStyle(color: Colors.white),
                        '1.0'
                        )

                  ],
                ),
              ),

                const SizedBox(
                  height: 10,
                ),
                Column(children: [
                 Center(
                   child: Column(
                     children: const [
                                         ],
                   ),
                 ),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}