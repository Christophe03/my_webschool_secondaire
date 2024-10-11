import 'dart:io';
import 'package:easy_localization/easy_localization.dart'; // Pour la gestion de la localisation
import 'package:flutter/material.dart';
import 'package:hive/hive.dart'; // Pour le stockage local
import '../utils/next_screen.dart';
import '../models/notification_model.dart';
import '../utils/constants_util.dart';
import '../utils/next_screen.dart';
import '../views/notifications/widgets/notification_dialog.dart';
import '../views/notifications/widgets/post_notification_details.dart';

class NotificationService {
  // Méthode pour initialiser les notifications push (Firebase désactivé ici)
  Future initPushNotification(context) async {
    if (Platform.isIOS) {
      _handleIosNotificationPermission();
    }
    // Exemple : Initialiser un jeton ou une autre configuration pour les notifications push.
    String? _token = ''; // Simuler l'initialisation du token

    // Exemple : Simuler le traitement du premier message reçu
    var initialMessage = {}; // Simulation d'un message reçu
    if (initialMessage != null) {
      await saveNotificationData(initialMessage)
          .then((value) => _navigateToDetailsScreen(context, initialMessage));
    }

    // Exemple : Simuler l'écoute de messages reçus en direct
    // Ici, on pourrait ajouter de la logique pour écouter et afficher des notifications.
  }

  // Méthode pour gérer les autorisations de notification iOS
  Future _handleIosNotificationPermission() async {
    // Exemple d'autorisation pour iOS (Firebase retiré)
    // Logique simulée pour demander une permission de notification
    bool permissionGranted = true; // On suppose que la permission est accordée
    if (permissionGranted) {
      debugPrint('Utilisateur a accordé la permission');
    } else {
      debugPrint('Utilisateur a refusé la permission');
    }
  }

  // Méthode pour ouvrir une boîte de dialogue de notification avec les détails du message
  Future _handleOpenNotificationDialog(context, dynamic message) async {
    DateTime now = DateTime.now();
    String _timestamp = DateFormat('yyyyMMddHHmmss').format(now);
    NotificationModel notificationModel = NotificationModel(
      date: now, // Simuler la date du message
      description: message['description'], // Simuler la description du message
      postId: message['post_id'], // Simuler l'ID du post
      thumbnailUrl: message['image_url'], // Simuler l'URL de l'image
      timestamp: _timestamp,
      title: message['title'], // Simuler le titre
      subTitle: message['body'], // Simuler le sous-titre
    );
    openNotificationDialog(
        context, notificationModel); // Ouvre une boîte de dialogue
  }

  // Méthode pour naviguer vers l'écran de détails de la notification
  Future _navigateToDetailsScreen(context, dynamic message) async {
    DateTime now = DateTime.now();
    String _timestamp = DateFormat('yyyyMMddHHmmss').format(now);
    NotificationModel notificationModel = NotificationModel(
      timestamp: _timestamp,
      date: now, // Simuler la date d'envoi
      title: message['title'], // Simuler le titre
      description: message['description'], // Simuler la description
      postId: message['post_id'], // Simuler l'ID du post
      thumbnailUrl: message['image_url'], // Simuler l'URL de l'image
      subTitle: message['body'], // Simuler le sous-titre
    );
    void navigateToNotificationDetailsScreen(
        BuildContext context, NotificationModel notificationModel) {
      if (notificationModel.postId == null) {
        nextScreen(context,
            CustomNotificationDetails(notificationModel: notificationModel));
      } else {
        nextScreen(context,
            PostNotificationDetails(postID: notificationModel.postId!));
      }
    }
  }

  // Méthode pour enregistrer les données d'une notification localement
  Future saveNotificationData(dynamic message) async {
    final list = Hive.box(notificationTag); // Ouvre la boîte Hive
    DateTime now = DateTime.now();
    String _timestamp = DateFormat('yyyyMMddHHmmss').format(now);

    // Structure des données de notification
    Map<String, dynamic> _notificationData = {
      'timestamp': _timestamp,
      'date': now, // Simuler la date
      'title': message['title'], // Simuler le titre
      'body': message['description'], // Simuler le contenu
      'post_id': message['post_id'], // Simuler l'ID du post
      'image': message['image_url'], // Simuler l'URL de l'image
      'subtitle': message['body'], // Simuler le sous-titre
    };

    await list.put(_timestamp, _notificationData); // Enregistrer dans Hive
  }

  // Méthode pour supprimer une notification spécifique
  Future deleteNotificationData(String key) async {
    final notificationList = Hive.box(notificationTag);
    await notificationList.delete(key); // Supprime la notification par clé
  }

  // Méthode pour supprimer toutes les notifications
  Future deleteAllNotificationData() async {
    final notificationList = Hive.box(notificationTag);
    await notificationList.clear(); // Supprime toutes les notifications
  }
}

void nextScreen(BuildContext context, Widget page) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}
