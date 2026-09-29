import 'package:flutter/material.dart';
import 'package:weather_app_flutter/UI/Screens/Custom_Widget.dart';
import 'package:weather_app_flutter/UI/Screens/Forgot%20Password%20Screen/New_Password_Screen.dart';

class Recover_Password_Screen extends StatefulWidget {
  const Recover_Password_Screen({super.key});

  @override
  State<Recover_Password_Screen> createState() => _Recover_Password_ScreenState();
}

class _Recover_Password_ScreenState extends State<Recover_Password_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff02150E),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(

            children: [

              Padding(
                padding: const EdgeInsets.only(top: 130, bottom: 20),
                child: Center(
                  child: Image.asset('Assets/Raining_cloud.png', width: 200, height: 200,),
                ),
              ),


              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: CustomTextField(label: 'Enter Code', hintText: '1 2 3 4', prefixIcon: Icons.mail_outline),
              ),





              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: PrimaryButton(text: 'Verify', color: Color(0xff25D366), onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const New_Password_Screen(),
                    ),
                  );
                },),
              ),











            ],
          ),
        ),
      ),
    );
  }
}
