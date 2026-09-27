import 'package:flutter/material.dart';
import 'package:weather_app_flutter/UI/Screens/Custom_Widget.dart';

class Login_Screen extends StatefulWidget {
  const Login_Screen({super.key});

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
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
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: CustomTextField(label: 'Enter Email', hintText: 'admin@gmail.com', prefixIcon: Icons.mail_outline),
              ),
              CustomTextField(label: 'Enter Password', hintText: '********', prefixIcon: Icons.lock_outline),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 10),
                    child: Text('Forgot Password?', style: TextStyle(color: Colors.white70, fontSize: 15),),
                  )
                ],
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: PrimaryButton(text: 'Sign in', color: Color(0xff25D366), onPressed: (){}),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: PrimaryButton(text: 'Sign up', color: Color(0xff041E12), onPressed: (){}),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text('Or Continue With', style: TextStyle(color: Colors.white70, fontSize: 15),),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Divider(),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 15, left: 35, right: 35),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height:65,
                      width: 120,
                      decoration: BoxDecoration(
                        color: Color(0xff041E12),
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('Assets/apple_logo.png', width: 15, height: 15,),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text('Apple', style: TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w600),),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 65,
                      width: 120,
                      decoration: BoxDecoration(
                        color: Color(0xff041E12),
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('Assets/google_logo.png', width: 15, height: 15,),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text('Google', style: TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w600),),
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              )








            ],
          ),
        ),
      ),
    );
  }
}
