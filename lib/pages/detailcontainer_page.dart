import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:simoco_rc/model/mqtt.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key, required this.mqttData}) : super(key: key);

  final mqttModel mqttData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blue[800],
      //bottomNavigationBar: BottomNavigation(),
      body: Container(
        height: 1000,
        //decoration: BoxDecoration(color: Colors.blue),
        decoration:  const BoxDecoration(color: Color(0xFF0D214F)),
        child: SafeArea(
          child: Column(children: [
            // Greetings row
            Padding(
              padding:  const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                children: [
                   const SizedBox(
                    height: 25,
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  const [
                        Text(
                          'Helow, Vega Anggaresta',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            ),
                          ),
                      ],
                    ),

                    //Notif
                      Container(
                        decoration:
                        BoxDecoration (
                          color: Colors.blue[600],
                          borderRadius: BorderRadius.circular(12)
                        ),
                        padding:  const EdgeInsets.all(12),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(context, 'profiles');
                          },
                          child:  const Icon(
                          Icons.settings,
                          color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),

                   const SizedBox(
                    height: 25,
                  ),
                  // Select container

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:  const [
                            Text(
                              'Monitoring Container',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                            ),
                          ),
                            Icon (
                              Icons.more_horiz,
                              color: Colors.white,
                            )
                          ],
                        ),

                   const SizedBox(
                    height: 15,
                  ),

                  // Box Data Container 4 Baris (Kiri->kanan)
                  Row(children: [
                    //Suhu Container
                    // Emoticonface(emoticonFace: '❄️',
                    // ),
                    Container(
                       padding:  const EdgeInsets.all(12),
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(10),
                         color: Colors.white,
                       ),
                       child:
                       Icon(FontAwesomeIcons.temperatureArrowUp,
                       color: Colors.blue[300],
                       )
                     ),
                     const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        const Text(
                          'Temperature',
                          style: TextStyle(color: Colors.white,
                          fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${mqttData.value.avgTmp} °C',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                         )
                        ],
                      ),
                       const SizedBox(
                        width: 30,
                      ),
                      Container(
                       padding:  const EdgeInsets.all(12),
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(10),
                         color: Colors.white,
                       ),
                       child:
                       Icon(FontAwesomeIcons.droplet,
                       color: Colors.blue[300],
                       )
                     ),
                      const SizedBox(
                      width: 10,
                     ),
                      Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        const Text(
                          'Humidity',
                          style: TextStyle(color: Colors.white,
                          fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${mqttData.value.avgHmd} %',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                         )
                        ],
                      ),
                    ],
                        ),
                      ],
                    ),
                  ),

               const SizedBox(
                height: 20,
              ),

              Expanded(
                child: ClipRRect(
                  borderRadius:  const BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25)
                        ),
                  child: Container(
                    color: Colors.grey[200],
                     child:Padding(
                       padding:  const EdgeInsets.symmetric(horizontal: 25.0),
                       child: Column(children: [
                        Center(
                          child: Column(
                            children: [
                              // Icon(Icons.expand_less_outlined),
                               const SizedBox(
                                height: 5,
                              ),
                              // Icon(Icons.expand_more),
                               const Icon(FontAwesomeIcons.ellipsis),

                               const SizedBox(
                                height: 5,
                              ),
                               const Text(
                                'Status AC Control',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17),
                              ),
                               const SizedBox(
                                height: 10,
                              ),
                              //list view card icon
                             // Status AC
                             Container(
                              padding:  const EdgeInsets.all(15),
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
                                        Container(
                                          padding:  const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Colors.amber,
                                          ),
                                          child:
                                           const Icon(FontAwesomeIcons.snowflake,
                                          color: Colors.white,
                                          )
                                          ),
                                         const SizedBox(
                                          width: 15,
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children:  [
                                            //Title
                                            const Text(
                                              'Status Evaporator',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                              ),
                                            //sub title
                                            Text('${mqttData.value.evap}')
                                          ],
                                        ),

                                      ],
                                    ),
                                     const Icon(Icons.more_horiz_outlined),
                                  ],
                                ),
                             ),
                              const SizedBox(
                                height: 10 ,
                             ),
                             //Status humidity
                              Container(
                              padding:  const EdgeInsets.all(15),
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
                                        Container(
                                          padding:  const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Colors.amber,
                                          ),
                                          child:
                                           const Icon(FontAwesomeIcons.snowflake,
                                          color: Colors.white,
                                          )
                                          ),
                                         const SizedBox(
                                          width: 15,
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children:  [
                                            //Title
                                            const Text(
                                              'Status Condenser',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                              ),
                                            //sub title
                                            Text("${mqttData.value.cond}"),
                                          ],
                                        ),
                                      ],
                                    ),
                                     const Icon(Icons.more_horiz_outlined),
                                  ],
                                ),
                             ),

                             //Status Condenser
                              const SizedBox(
                                height: 10 ,
                             ),
                             //Status humidity
                              Container(
                              padding:  const EdgeInsets.all(15),
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
                                        Container(
                                          padding:  const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Colors.amber,
                                          ),
                                          child:
                                           const Icon(FontAwesomeIcons.waterLadder,
                                          color: Colors.white,
                                          )
                                          ),
                                         const SizedBox(
                                          width: 15,
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children:  [
                                            //Title
                                            const Text(
                                              'Status Compressor',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                              ),
                                            //sub title
                                            Text('${mqttData.value.comp}'),
                                          ],
                                        ),

                                      ],
                                    ),
                                     const Icon(Icons.more_horiz_outlined),
                                  ],
                                ),
                             ),

                             //Status Heater
                              const SizedBox(
                                height: 10 ,
                             ),
                             //Status humidity
                              Container(
                              padding:  const EdgeInsets.all(15),
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
                                        Container(
                                          padding:  const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Colors.amber,
                                          ),
                                          child:
                                           const Icon(FontAwesomeIcons.water,
                                          color: Colors.white,
                                          )
                                          ),
                                         const SizedBox(
                                          width: 15,
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children:  [
                                            //Title
                                            const Text(
                                              'Status Heater',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                              ),
                                            //sub title
                                            Text('${mqttData.value.heat}')
                                          ],
                                        ),

                                      ],
                                    ),
                                     const Icon(Icons.more_horiz_outlined),
                                  ],
                                ),
                             ),

                            ],
                          ),
                        ),
                    ]),
                     ),
                    // decoration: BoxDecoration(
                    //   // color: Colors.white,
                    //
                    // child: Center(
                    // ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
}}