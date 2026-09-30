import 'package:flutter/material.dart';
import 'package:weather_app_flutter/UI/Screens/Custom_Widget.dart';

class Profile_Screen extends StatefulWidget {
  const Profile_Screen({super.key});

  @override
  State<Profile_Screen> createState() => _Profile_ScreenState();
}

class _Profile_ScreenState extends State<Profile_Screen> {
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
                padding: const EdgeInsets.only(top: 120, bottom: 20),
                child: CircleAvatar(backgroundImage: AssetImage('Assets/profile_picture.jpg'), radius: 80,),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: CustomTextField(label: 'Chnage Name', hintText: 'Alex John', prefixIcon: Icons.mail_outline),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: CustomTextField(label: 'Change Password', hintText: '********', prefixIcon: Icons.mail_outline),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: CustomTextField(label: 'Change City', hintText: 'Lahore,PK', prefixIcon: Icons.lock_outline),
              ),



              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: PrimaryButton(text: 'Log Out', color: Color(0xff25D366), onPressed: (){}),
              ),











            ],
          ),
        ),
      ),
    );
  }
}
