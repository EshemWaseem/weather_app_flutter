import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_flutter/UI/Screens/Custom_Widget.dart';
import '../../../Providers/forgot_password_provider.dart'; // Apna path verify kar lijiye ga

class Forgot_Password_Screen extends StatefulWidget {
  const Forgot_Password_Screen({super.key});

  @override
  State<Forgot_Password_Screen> createState() => _Forgot_Password_ScreenState();
}

class _Forgot_Password_ScreenState extends State<Forgot_Password_Screen> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Provider ko access karein
    final provider = context.watch<ForgotPasswordProvider>();

    return Scaffold(
      backgroundColor: const Color(0xff02150E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 80, bottom: 20),
                child: Center(
                  child: Image.asset(
                    'Assets/Raining_cloud.png',
                    width: 200,
                    height: 200,
                  ),
                ),
              ),

              const Text(
                'Reset Password',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Enter your email address and we will send you a link to reset your password.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 30),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: CustomTextField(
                  label: 'Enter Email',
                  hintText: 'alex_john@gmail.com',
                  prefixIcon: Icons.mail_outline,
                  controller: _emailController, // Controller assign kiya
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: provider.isLoading
                    ? const CircularProgressIndicator(color: Color(0xff25D366))
                    : PrimaryButton(
                  text: 'Send Reset Link',
                  color: const Color(0xff25D366),
                  onPressed: () {
                    // Provider ka function call kiya
                    context.read<ForgotPasswordProvider>().sendPasswordResetEmail(
                      _emailController.text,
                      context,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}