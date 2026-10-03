import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Providers/signin_provider.dart';
import '../Custom_Widget.dart';


class Login_Screen extends StatefulWidget {
  const Login_Screen({super.key});

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSignIn() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) return;

    final success = await context.read<SigninProvider>().signIn(email, password);

    if (!mounted) return;
    if (success) {
      Navigator.pushReplacementNamed(context, '/dashboard');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.read<SigninProvider>().errorMessage ?? 'Error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SigninProvider>();

    return Scaffold(
      backgroundColor: const Color(0xff02150E),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 130, bottom: 20),
                child: Image.asset('Assets/Raining_cloud.png', width: 200, height: 200),
              ),

              CustomTextField(
                label: 'Enter Email', hintText: 'admin@gmail.com',
                prefixIcon: Icons.mail_outline, controller: _emailController,
              ),

              const SizedBox(height: 15),

              CustomTextField(
                label: 'Enter Password', hintText: '********',
                prefixIcon: Icons.lock_outline, controller: _passwordController,
                isObscure: true,
              ),

              // Forgot Password Button Added Here
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/forgot-password');
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Color(0xff25D366), // App ka green color
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 30),
                child: PrimaryButton(
                  text: 'Sign in', isLoading: provider.isLoading, onPressed: _handleSignIn,
                ),
              ),

              PrimaryButton(
                text: 'Sign up', color: const Color(0xff041E12),
                onPressed: () => Navigator.pushNamed(context, '/signup'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}