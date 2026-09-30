import 'package:flutter/material.dart';
import 'package:weather_app_flutter/UI/Screens/Custom_Widget.dart';
import 'package:weather_app_flutter/UI/Screens/Login%20Screen/Login_Screen.dart';

class New_Password_Screen extends StatefulWidget {
  const New_Password_Screen({super.key});

  @override
  State<New_Password_Screen> createState() => _New_Password_ScreenState();
}

class _New_Password_ScreenState extends State<New_Password_Screen> {
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
                child: CustomTextField(label: 'Enter New Password', hintText: '********', prefixIcon: Icons.mail_outline),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: CustomTextField(label: 'Confirm Password', hintText: '********', prefixIcon: Icons.mail_outline),
              ),





              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: PrimaryButton(text: 'Change Password', color: Color(0xff25D366), onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Login_Screen(),
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
