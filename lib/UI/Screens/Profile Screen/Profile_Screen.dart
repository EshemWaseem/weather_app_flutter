import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Custom_Widget.dart';

class Profile_Screen extends StatefulWidget {
  const Profile_Screen({super.key});

  @override
  State<Profile_Screen> createState() => _Profile_ScreenState();
}

class _Profile_ScreenState extends State<Profile_Screen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  User? _currentUser;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _loadCurrentUserData();
  }

  void _loadCurrentUserData() {
    _currentUser = FirebaseAuth.instance.currentUser;
    if (_currentUser != null) {
      _nameController.text = _currentUser!.displayName ?? '';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  Future<void> _updateProfile() async {
    if (_currentUser == null) return;

    final newName = _nameController.text.trim();
    final newPassword = _passwordController.text.trim();

    setState(() => _isSaving = true);

    try {
      if (newName.isNotEmpty && newName != _currentUser!.displayName) {
        await _currentUser!.updateDisplayName(newName);
      }

      if (newPassword.isNotEmpty) {
        await _currentUser!.updatePassword(newPassword);
        _passwordController.clear();
      }

      await _currentUser!.reload();
      _currentUser = FirebaseAuth.instance.currentUser;

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile updated successfully!'),
          backgroundColor: Color(0xff25D366),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? 'Update failed.'),
          backgroundColor: Colors.redAccent,
        ),
      );
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  void _handleLogout() async {
    try {
      await FirebaseAuth.instance.signOut();
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error logging out: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final String displayName = _currentUser?.displayName ?? 'Weather User';
    final String email = _currentUser?.email ?? 'Not available';

    return Scaffold(
      backgroundColor: const Color(0xff02150E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('My Profile', style: TextStyle(color: Colors.white, fontSize: 18)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              const SizedBox(height: 10),
              // User Avatar
              const CircleAvatar(
                backgroundImage: AssetImage('Assets/profile_picture.jpg'),
                radius: 65,
                backgroundColor: Color(0xff041E12),
              ),
              const SizedBox(height: 14),

              // Dynamic Logged-in User Information
              Text(
                displayName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                email,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 24),

              // Change Name Field (Pre-filled)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: CustomTextField(
                  label: 'Change Name',
                  hintText: 'Enter new name',
                  prefixIcon: Icons.person_outline,
                  controller: _nameController,
                ),
              ),

              // Change Password Field
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: CustomTextField(
                  label: 'Change Password',
                  hintText: 'Enter new password',
                  prefixIcon: Icons.lock_outline,
                  controller: _passwordController,
                  isObscure: true,
                ),
              ),

              // Change City Field
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: CustomTextField(
                  label: 'Preferred City',
                  hintText: 'e.g. Lahore, PK',
                  prefixIcon: Icons.location_on_outlined,
                  controller: _cityController,
                ),
              ),

              const SizedBox(height: 16),

              // Save Changes Button
              PrimaryButton(
                text: 'Save Changes',
                color: const Color(0xff041E12),
                isLoading: _isSaving,
                onPressed: _updateProfile,
              ),

              const SizedBox(height: 12),

              // Log Out Button
              PrimaryButton(
                text: 'Log Out',
                color: const Color(0xff25D366),
                onPressed: _handleLogout,
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}