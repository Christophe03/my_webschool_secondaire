import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../models/notification_model.dart';

class CustomNotificationCard extends StatelessWidget {
  const CustomNotificationCard({
    Key? key,
    required this.notificationModel,
    required this.timeAgo,
  }) : super(key: key);

  final NotificationModel notificationModel;
  final String timeAgo;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorLight,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    notificationModel.title!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IconButton(
                  constraints: BoxConstraints(minHeight: 40),
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.all(0),
                  icon: Icon(
                    Icons.close,
                    size: 20,
                  ),
                  onPressed: () {
                    // Logique pour supprimer la notification (données statiques)
                    // Remplacez cela par une méthode statique si nécessaire
                    print(
                        'Notification supprimée: ${notificationModel.timestamp}');
                  },
                ),
              ],
            ),
            SizedBox(height: 5),
            Text(
              notificationModel.description!,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).secondaryHeaderColor,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  CupertinoIcons.time,
                  size: 18,
                  color: Colors.grey,
                ),
                SizedBox(width: 5),
                Text(
                  timeAgo,
                  style: TextStyle(
                    fontSize: 13,
                    color: Theme.of(context).secondaryHeaderColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      onTap: () {
        if (notificationModel.postId == null) {
          // nextScreen(context, CustomNotificationDetails(notificationModel: notificationModel));
        } else {
          // nextScreen(context, PostNotificationDetails(postID: notificationModel.postId!));
        }
      },
    );
  }
}
