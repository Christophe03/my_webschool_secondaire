import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../models/notification_model.dart';
import '../empty/empty_view.dart';
import 'widgets/custom_notification_card.dart';
import 'widgets/post_notification_card.dart';
import '../../widgets/app_name.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Exemple de données statiques pour les notifications
    final List<Map<String, dynamic>> items = [
      {
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'date': '2024-10-10',
        'title': 'Notification 1',
        'body': 'Ceci est le corps de la notification 1.',
        'post_id': '1',
        'image': 'url_image_1',
        'subtitle': 'Sous-titre 1',
      },
      {
        'timestamp': DateTime.now().millisecondsSinceEpoch - 10000,
        'date': '2024-10-09',
        'title': 'Notification 2',
        'body': 'Ceci est le corps de la notification 2.',
        'post_id': null,
        'image': 'url_image_2',
        'subtitle': 'Sous-titre 2',
      },
      // Ajoutez d'autres notifications ici
    ];

    void _openClearAllDialog() {
      showModalBottomSheet(
        elevation: 2,
        enableDrag: true,
        isDismissible: true,
        isScrollControlled: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(20),
            height: 210,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'clear_all_notification_dialog'.tr(),
                    style: TextStyle(
                      color: Colors.black, // Remplacez par kColorDark si défini
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.6,
                      wordSpacing: 1,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.resolveWith(
                          (states) => const Size(100, 50),
                        ),
                        backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => Theme.of(context).primaryColor,
                        ),
                        shape: MaterialStateProperty.resolveWith(
                          (states) => RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      onPressed: () {
                        // Supprimer les notifications ici (logique statique)
                        Navigator.pop(context);
                      },
                      child: RichText(
                        text: TextSpan(
                          text: 'yes'.tr(),
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    TextButton(
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.resolveWith(
                          (states) => const Size(100, 50),
                        ),
                        backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.grey[400],
                        ),
                        shape: MaterialStateProperty.resolveWith(
                          (states) => RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: RichText(
                        text: TextSpan(
                          text: 'cancel'.tr(),
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: AppName(
          fontSize: 19.0,
          school: 'notifications'.tr(),
        ),
        iconTheme: const IconThemeData(
            color: Colors.white), // Remplacez par kColorLight si défini
        backgroundColor: Colors.blue, // Remplacez par kColorPrimary si défini
        foregroundColor: Colors.white, // Remplacez par kColorLight si défini
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () => _openClearAllDialog(),
            style: ButtonStyle(
              padding: MaterialStateProperty.resolveWith(
                (states) => const EdgeInsets.only(right: 15, left: 15),
              ),
            ),
            child: AppName(
              fontSize: 19.0,
              school: 'clear_all'.tr(),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Remplacement du ValueListenableBuilder par une liste statique
          if (items.isEmpty)
            EmptyView(
              icon: Icons.circle_notifications,
              message: 'no_notification_title'.tr(),
              message1: 'no_notification_description'.tr(),
            )
          else
            _NotificationList(items: items),
        ],
      ),
    );
  }
}

class _NotificationList extends StatelessWidget {
  const _NotificationList({
    Key? key,
    required this.items,
  }) : super(key: key);

  final List<Map<String, dynamic>> items;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 30),
        itemCount: items.length,
        separatorBuilder: (context, index) => const SizedBox(height: 15),
        itemBuilder: (BuildContext context, int index) {
          final NotificationModel notificationModel = NotificationModel(
            timestamp: items[index]['timestamp'],
            date: items[index]['date'],
            title: items[index]['title'],
            description: items[index]['body'],
            postId: items[index]['post_id'],
            thumbnailUrl: items[index]['image'],
            subTitle: items[index]['subtitle'] ?? '',
          );

          // Utilisez une valeur fictive pour timeAgo ici
          final String timeAgo = 'timeAgo';

          if (notificationModel.postId == null) {
            return CustomNotificationCard(
                notificationModel: notificationModel, timeAgo: timeAgo);
          } else {
            return PostNotificationCard(
              notificationModel: notificationModel,
              timeAgo: timeAgo,
            );
          }
        },
      ),
    );
  }
}
