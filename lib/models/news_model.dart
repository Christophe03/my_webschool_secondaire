import 'dart:convert';

class NewsModel {
  String? id;
  String? message;
  String? categorie;
  String? color;
  String? sender;
  String? timestamp;
  String title;
  String description;

  NewsModel({
    this.id,
    this.message,
    this.categorie,
    this.color,
    this.sender,
    this.timestamp,
    required this.title,
    required this.description,
  });

  // Exemple de données statiques
  static List<NewsModel> generateSampleData() {
    return [
      NewsModel(
        id: "1",
        message: "Nouveau cours de programmation disponible !",
        categorie: "Éducation",
        color: "blue",
        sender: "Admin",
        timestamp: "2024-01-01 10:00:00",
        title: "Cours de programmation",
        description:
            "Découvrez notre nouveau cours complet sur la programmation.",
      ),
      NewsModel(
        id: "2",
        message: "Mise à jour sur les événements à venir.",
        categorie: "Événements",
        color: "green",
        sender: "Équipe d'événements",
        timestamp: "2024-01-02 12:00:00",
        title: "Événements à venir",
        description:
            "Ne manquez pas les événements importants à venir dans notre communauté.",
      ),
      // Ajoutez d'autres instances si nécessaire
    ];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'message': message,
      'categorie': categorie,
      'color': color,
      'sender': sender,
      'timestamp': timestamp,
      'title': title,
      'description': description,
    };
  }

  String toJson() => json.encode(toMap());
}
