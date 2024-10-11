import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants_util.dart';
import '../utils/string_util.dart';

class SignInProvider extends ChangeNotifier {
  SignInProvider() {
    checkSignIn();
  }

  final String defaultUserImageUrl =
      'https://firebasestorage.googleapis.com/v0/b/ws-portail-sup.appspot.com/o/app%2Fprofil.png?alt=media&token=ff1fe0b7-0f2b-49ac-97c1-e2847dcbc980';

  String signInProvider = "";
  bool _isSignedIn = true;
  bool get isSignedIn => _isSignedIn;

  bool _hasError = false;
  bool get hasError => _hasError;

  String? _errorMessage;
  String get errorMessage => _errorMessage ?? '';

  // Method to sign up with email and password
  Future<String> signUpWithEmailPassword(
      String userName, String userEmail, String userPassword) async {
    // Simulating a successful sign up and returning a static UID
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    signInProvider = 'email';
    _hasError = false;
    notifyListeners();
    return 'static-uid'; // Replace with actual user ID when integrating with real authentication
  }

  // Method to sign in with email and password
  Future<String> signInWithEmailPassword(
      String userEmail, String userPassword) async {
    // Simulating a successful sign in and returning a static UID
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    signInProvider = 'email';
    _hasError = false;
    notifyListeners();
    return 'static-uid'; // Replace with actual user ID when integrating with real authentication
  }

  // Method to reset the password
  Future resetPassword(String email) async {
    // Simulating a password reset action
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    _hasError = false;
    notifyListeners();
  }

  // Method to check if a user exists (simulated)
  Future<bool> checkUserExists(String uid) async {
    // Simulating a user check, assuming user exists
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    return true; // Replace with actual user existence check
  }

  // Method to save user data (simulated)
  Future<void> saveUserData(String uid, String name, String phone, String email,
      String provider) async {
    // Simulating saving user data
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
  }

  // Method to check sign-in status
  void checkSignIn() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    _isSignedIn = sp.getBool('signed_in') ?? false;
    notifyListeners();
  }

  // Method to sign out the user
  Future userSignOut() async {
    // Simulating user sign out
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    signInProvider = '';
    _isSignedIn = false;
    notifyListeners();
  }

  // Method to clear all data on sign out
  Future clearAllData() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
  }
}
