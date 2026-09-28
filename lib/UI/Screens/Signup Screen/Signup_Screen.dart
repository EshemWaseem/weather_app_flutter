import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Providers/signup_provider.dart';
import '../Custom_Widget.dart';

class Signup_Screen extends StatefulWidget {
  const Signup_Screen({super.key});

  @override
  State<Signup_Screen> createState() => _Signup_ScreenState();
}

class _Signup_ScreenState extends State<Signup_Screen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSignUp() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) return;

    final success = await context.read<SignupProvider>().signUp(name, email, password);

    if (!mounted) return;
    if (success) {
      Navigator.pushReplacementNamed(context, '/dashboard');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.read<SignupProvider>().errorMessage ?? 'Error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SignupProvider>();

    return Scaffold(
      backgroundColor: const Color(0xff02150E),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 100, bottom: 20),
                child: Image.asset('Assets/Raining_cloud.png', width: 150, height: 150),
              ),
              CustomTextField(
                label: 'Enter Name', hintText: 'Alex John',
                prefixIcon: Icons.person_outline, controller: _nameController,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                label: 'Enter Email', hintText: 'admin@gmail.com',
                prefixIcon: Icons.mail_outline, controller: _emailController,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                label: 'Enter Password', hintText: '********',
                prefixIcon: Icons.lock_outline, controller: _passwordController,
                isObscure: true,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: PrimaryButton(
                  text: 'Sign up', isLoading: provider.isLoading, onPressed: _handleSignUp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}