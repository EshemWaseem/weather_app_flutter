import 'package:flutter/material.dart';
import 'package:weather_app_flutter/UI/Screens/Custom_Widget.dart';
import 'package:weather_app_flutter/UI/Screens/Forgot%20Password%20Screen/Recover_Password_Screen.dart';

class Forgot_Password_Screen extends StatefulWidget {
  const Forgot_Password_Screen({super.key});

  @override
  State<Forgot_Password_Screen> createState() => _Forgot_Password_ScreenState();
}

class _Forgot_Password_ScreenState extends State<Forgot_Password_Screen> {
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
                child: CustomTextField(label: 'Enter Email', hintText: 'alex_john@gmail.com', prefixIcon: Icons.mail_outline),
              ),





              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: PrimaryButton(text: 'Send Code', color: Color(0xff25D366), onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Recover_Password_Screen(),
                    ),
                  );
                }),
              ),











            ],
          ),
        ),
      ),
    );
  }
}
