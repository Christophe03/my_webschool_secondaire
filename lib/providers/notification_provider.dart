import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationProvider extends ChangeNotifier {
  bool? _subscribed;
  bool? get subscribed => _subscribed;

  // This method is used to initialize push notifications (without Firebase).
  Future initPushNotification(BuildContext context) async {
    if (Platform.isIOS) {
      // Here you can implement iOS-specific logic for notifications, if needed
    }

    // You can add local notification logic or other third-party services here
    handleSubscription();

    notifyListeners();
  }

  Future handleSubscription() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    bool getSubscription = sp.getBool('subscribe') ?? true;
    _subscribed = getSubscription;
    await sp.setBool('subscribe', _subscribed!);
    notifyListeners();
  }

  Future updateSubscription(bool isSubscribed) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setBool('subscribe', isSubscribed);
    _subscribed = isSubscribed;
    notifyListeners();
  }

  void fcmSubscribe(bool bool) {}
}
