import 'package:flutter/material.dart';
import '../models/notification_model.dart';

class CustomNotificationDetails extends StatelessWidget {
  final NotificationModel notificationModel;

  const CustomNotificationDetails({Key? key, required this.notificationModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(notificationModel.message ?? 'No message available'),
      ),
    );
  }
}
