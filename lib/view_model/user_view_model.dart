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

  String get userEmail => _user?.email ?? 'No email';

  String get userName => _user?.displayName ?? 'Person';

  UserViewModel() {
    loadUserSession();
  }

  // Sign up method
  Future<void> signUp(String email, String password, String username) async {
    // Check for empty fields
    if (email.isEmpty || password.isEmpty || username.isEmpty) {
      Get.snackbar('Error', 'All fields must be filled out.',
          snackPosition: SnackPosition.TOP);
      return;
    }

    password = password.trim(); // Trim any whitespace
    print(
        'Attempting to sign up with password: "$password" (Length: ${password.length})');

    // Validate password before proceeding to sign-up
    if (!_isValidPassword(password)) {
      Get.snackbar('Error',
          'Password must be at least 8 characters long, include uppercase, lowercase, number, and special character.',
          snackPosition: SnackPosition.TOP);
      return;
    }

    print('Password is valid, proceeding with sign-up.');

    try {
      _user = await _userRepository.signUp(email, password, username);
      if (_user != null) {
        _saveUserSession(_user!.uid);
        Get.snackbar('Success', 'Sign up successful!',
            snackPosition: SnackPosition.TOP);

        Get.offNamed('/home');
      }
    } catch (e) {
      String errorMessage = _getErrorMessage(e);
      Get.snackbar('Error', errorMessage, snackPosition: SnackPosition.TOP);
    }
    notifyListeners();
  }

  // Sign in method
  Future<void> signIn(String email, String password) async {
    // Check for empty fields
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Email and password must be filled out.',
          snackPosition: SnackPosition.TOP);
      return;
    }

    try {
      _user = await _userRepository.signIn(email, password);
      if (_user != null) {
        _saveUserSession(_user!.uid);
        Get.snackbar('Success', 'Sign in successful!',
            snackPosition: SnackPosition.TOP);

        Get.offNamed('/home');
      }
    } catch (e) {
      String errorMessage = _getErrorMessage(e);
      Get.snackbar('Error', errorMessage, snackPosition: SnackPosition.TOP);
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
            snackPosition: SnackPosition.TOP);

        Get.offNamed('/home');
      }
    } catch (e) {
      String errorMessage = _getErrorMessage(e);
      Get.snackbar('Error', errorMessage, snackPosition: SnackPosition.TOP);
    }
    notifyListeners();
  }

  // Sign out method
  Future<void> signOut() async {
    await _userRepository.signOut();
    _user = null;
    _clearUserSession();
    notifyListeners();
    // Optionally navigate to the login page
    Get.offNamed('/sign-in');
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
      // If user is found, navigate to home page
      if (_user != null) {
        Get.offNamed('/home'); // Adjust the route as needed
      }
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
      switch (error.code) {
        case 'email-already-in-use':
          return 'The email address is already in use by another account.';
        case 'invalid-email':
          return 'The email address is not valid.';
        case 'user-not-found':
          return 'No user found for that email.';
        case 'wrong-password':
          return 'Wrong password provided for that user.';
        default:
          return error.message ??
              'An unknown error occurred in authentication.';
      }
    }
    return '$error';
  }
}
