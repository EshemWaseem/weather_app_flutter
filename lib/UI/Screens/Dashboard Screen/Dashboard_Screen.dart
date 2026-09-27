import 'package:flutter/material.dart';

class Dashboard_Screen extends StatefulWidget {
  const Dashboard_Screen({super.key});

  @override
  State<Dashboard_Screen> createState() => _Dashboard_ScreenState();
}

class _Dashboard_ScreenState extends State<Dashboard_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff02150E),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
              flex: 7,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xff25D366),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80), bottomRight: Radius.circular(80)),

                ),
                child: Column(

                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30, right: 10),
                          child: Icon(Icons.settings_outlined, color: Colors.white, size: 30, ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: [
                          Icon(Icons.location_on, color: Colors.white, size: 20,),
                          Text('Lahore, PK', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),)

                        ],
                      ),
                    ),  // location wala text
                    Padding(
                      padding: const EdgeInsets.only(top: 70),
                      child: Image.asset('Assets/Raining_cloud.png', width: 200, height: 200,),
                    ),  // cloud image
                    Padding(
                      padding: EdgeInsets.only(left: 10, top: 20),
                      child: Center(
                        child: Text('21°', style: TextStyle(color: Colors.white, fontSize: 70, fontWeight: FontWeight.w900),),
                      ),
                    ),  // 21
                    Text('Thunderstorm', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),),  // Thunderstorm
                    Padding(
                      padding: const EdgeInsets.only(top: 70),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            child: Column(
                              children: [
                                Icon(Icons.air_outlined, color: Colors.white, size: 20,),
                                Text('13km/h', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),),
                                Text('wind', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w200),),
                              ],

                            ),
                          ),
                          Container(
                            width: 100,
                            height: 100,
                            child: Column(
                              children: [
                                Icon(Icons.water_drop_outlined, color: Colors.white, size: 20,),
                                Text('24%', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),),
                                Text('humidity', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w200),),
                              ],

                            ),
                          ),
                          Container(
                            width: 100,
                            height: 100,
                            child: Column(
                              children: [
                                Icon(Icons.grain, color: Colors.white, size: 20,),
                                Text('80%', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),),
                                Text('rain chance', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w200),),
                              ],

                            ),
                          ),


                        ],
                      ),
                    ),  //wind, humidity, rain chance




                  ],
                ),

              ),

          ),


          Flexible(flex: 2,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, bottom: 10, top: 10),
                    child: Text('Today', style: TextStyle(fontSize: 20, color: Colors.white70),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20, bottom: 10, top: 10),
                    child: Text('7 Days >', style: TextStyle(fontSize: 20, color: Colors.white70),),
                  ),

                ],
              ),      //Today  and 7 days text
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 130,
                      width: 85,
                      decoration: BoxDecoration(
                        color: Color(0xff041E12),
                        borderRadius: BorderRadius.circular(20)
                      ),


                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10, ),
                            child: Text('31°', style: TextStyle(color: Colors.white70, fontSize: 20, fontWeight: FontWeight.w200),),
                          ),
                          Image.asset('Assets/raining_cloud_green.png', height: 45, width: 45,),
                          Padding(
                            padding: const EdgeInsets.only(  bottom: 10),
                            child: Text('12:00', style: TextStyle(color: Colors.white70, fontSize: 15, fontWeight: FontWeight.w200),),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 130,
                      width: 85,
                      decoration: BoxDecoration(
                        color: Color(0xff041E12),
                        borderRadius: BorderRadius.circular(20)
                      ),


                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10, ),
                            child: Text('32°', style: TextStyle(color: Colors.white70, fontSize: 20, fontWeight: FontWeight.w200),),
                          ),
                          Image.asset('Assets/raining_cloud_green.png', height: 45, width: 45,),
                          Padding(
                            padding: const EdgeInsets.only(  bottom: 10),
                            child: Text('01:00', style: TextStyle(color: Colors.white70, fontSize: 20, fontWeight: FontWeight.w200),),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 130,
                      width: 85,
                      decoration: BoxDecoration(
                        color: Color(0xff041E12),
                        borderRadius: BorderRadius.circular(20)
                      ),


                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10, ),
                            child: Text('33°', style: TextStyle(color: Colors.white70, fontSize: 20, fontWeight: FontWeight.w200),),
                          ),
                          Image.asset('Assets/raining_cloud_green.png', height: 45, width: 45,),
                          Padding(
                            padding: const EdgeInsets.only(  bottom: 10),
                            child: Text('02:00', style: TextStyle(color: Colors.white70, fontSize: 20, fontWeight: FontWeight.w200),),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 130,
                      width: 85,
                      decoration: BoxDecoration(
                        color: Color(0xff041E12),
                        borderRadius: BorderRadius.circular(20)
                      ),


                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10, ),
                            child: Text('34°', style: TextStyle(color: Colors.white70, fontSize: 20, fontWeight: FontWeight.w200),),
                          ),
                          Image.asset('Assets/raining_cloud_green.png', height: 45, width: 45,),
                          Padding(
                            padding: const EdgeInsets.only(  bottom: 10),
                            child: Text('03:00', style: TextStyle(color: Colors.white70, fontSize: 20, fontWeight: FontWeight.w200),),
                          ),
                        ],
                      ),
                    ),




                  ],
                ),
              ),     // vertical days data
            ],
          ),),


        ],
      ),


    );
  }
}
