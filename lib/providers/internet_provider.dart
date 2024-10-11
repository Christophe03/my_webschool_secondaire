import 'dart:io'; // For checking internet connection
import 'package:flutter/material.dart';

class InternetProvider extends ChangeNotifier {
  bool _hasInternet = false;

  InternetProvider() {
    _checkInitialConnectivity();
    _listenToConnectivityChanges();
  }

  bool get hasInternet => _hasInternet;

  // Method to check initial internet connectivity using a simple HTTP request
  void _checkInitialConnectivity() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      _hasInternet = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      _hasInternet = false;
    }
    notifyListeners();
  }

  // Method to manually listen to changes (if needed, could be replaced with a periodic check)
  void _listenToConnectivityChanges() {
    // Here we could run a periodic check or use another way to track connection changes
    Future.delayed(Duration(seconds: 10), () async {
      _checkInitialConnectivity(); // Periodic check every 10 seconds (example)
    });
  }
}
