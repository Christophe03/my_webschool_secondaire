import 'package:flutter/material.dart';

class PostNotificationDetails extends StatefulWidget {
  final String postID;

  const PostNotificationDetails({super.key, required this.postID});

  @override
  _PostNotificationDetailsState createState() =>
      _PostNotificationDetailsState();
}

class _PostNotificationDetailsState extends State<PostNotificationDetails> {
  // Utilisation d'un modèle de données statiques pour l'exemple
  late final String title;
  late final String content;
  late final String contentType;

  @override
  void initState() {
    super.initState();
    // Initialiser des données statiques pour le post
    title = 'Titre de l\'article de notification';
    content =
        'Ceci est le contenu de l\'article de notification. Voici quelques détails supplémentaires sur le sujet.';
    contentType = 'texte'; // Par exemple, 'image', 'video', ou 'texte'
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    // Afficher le contenu en fonction du type
    if (contentType == 'image') {
      return Center(child: Text('Affichage d\'une image ici.'));
      // Ajoutez le widget d'image ici si nécessaire
    } else if (contentType == 'video') {
      return Center(child: Text('Affichage d\'une vidéo ici.'));
      // Ajoutez le widget vidéo ici si nécessaire
    } else {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(content),
      );
    }
  }
}
