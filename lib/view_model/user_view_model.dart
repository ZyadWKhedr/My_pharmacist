import 'package:healio/model/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserViewModel extends ChangeNotifier {
  final UserRepository _userRepository = UserRepository();
  User? _user;

  User? get user => _user;

  bool get isSignedIn => _user != null;

  UserViewModel() {
    loadUserSession();
  }

  // Sign up method
  Future<void> signUp(String email, String password, String username) async {
    password = password.trim(); // Trim any whitespace
    print(
        'Attempting to sign up with password: "$password" (Length: ${password.length})');
    print(password);

    // Validate password before proceeding to sign-up
    if (!_isValidPassword(password)) {
      Get.snackbar('Error',
          'Password must be at least 8 characters long, include uppercase, lowercase, number, and special character.',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    print('Password is valid, proceeding with sign-up.');

    try {
      _user = await _userRepository.signUp(email, password, username);
      if (_user != null) {
        _saveUserSession(_user!.uid);
        Get.snackbar('Success', 'Sign up successful!',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      String errorMessage = _getErrorMessage(e);
      Get.snackbar('Error', errorMessage, snackPosition: SnackPosition.BOTTOM);
    }
    print('Entered password: "$password"');
    notifyListeners();
  }

  // Sign in method
  Future<void> signIn(String email, String password) async {
    try {
      _user = await _userRepository.signIn(email, password);
      if (_user != null) {
        _saveUserSession(_user!.uid);
        Get.snackbar('Success', 'Sign in successful!',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      String errorMessage = _getErrorMessage(e);
      Get.snackbar('Error', errorMessage, snackPosition: SnackPosition.BOTTOM);
    }
    notifyListeners();
  }

  // Google Sign-In method
  Future<void> signInWithGoogle() async {
    try {
      _user = await _userRepository.signInWithGoogle();
      if (_user != null) {
        _saveUserSession(_user!.uid);
        Get.snackbar('Success', 'Google sign-in successful!',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      String errorMessage = _getErrorMessage(e);
      Get.snackbar('Error', errorMessage, snackPosition: SnackPosition.BOTTOM);
    }
    notifyListeners();
  }

  // Sign out method
  Future<void> signOut() async {
    await _userRepository.signOut();
    _user = null;
    _clearUserSession();
    notifyListeners();
  }

  // Validate password format
  bool _isValidPassword(String password) {
    final RegExp passwordRegex = RegExp(
        r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
    return passwordRegex.hasMatch(password);
  }

  Future<void> _saveUserSession(String uid) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('uid', uid);
  }

  Future<void> loadUserSession() async {
    final prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString('uid');
    if (uid != null) {
      // Only assign user if there's a UID
      _user = FirebaseAuth.instance.currentUser;
    }
    notifyListeners();
  }

  Future<void> _clearUserSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('uid');
  }

  // Get user-friendly error message
  String _getErrorMessage(Object error) {
    if (error is FirebaseAuthException) {
      return error.message ?? 'An unknown error occurred.';
    }
    return 'An unknown error occurred.';
  }
}
