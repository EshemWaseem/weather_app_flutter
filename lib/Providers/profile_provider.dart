import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isLoading = false;
  String? _errorMessage;
  String? _successMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;

  // Get current user details
  User? get currentUser => _auth.currentUser;

  // Log Out Method
  Future<bool> logOut() async {
    _isLoading = true;
    notifyListeners();

    try {
      await _auth.signOut();
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = "Failed to log out: $e";
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Update Name Method
  Future<bool> updateName(String newName) async {
    if (newName.isEmpty) return false;
    _isLoading = true;
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();

    try {
      await currentUser?.updateDisplayName(newName);
      await currentUser?.reload(); // Refresh the user object
      _successMessage = "Name updated successfully!";
      _isLoading = false;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      _errorMessage = e.message ?? "Failed to update name.";
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Update Password Method
  Future<bool> updatePassword(String newPassword) async {
    if (newPassword.isEmpty) return false;
    _isLoading = true;
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();

    try {
      await currentUser?.updatePassword(newPassword);
      _successMessage = "Password updated successfully!";
      _isLoading = false;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      _errorMessage = e.message ?? "Failed to update password. You may need to log in again first.";
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}