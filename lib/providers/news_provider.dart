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

  // Ajout de la méthode `fromMap` pour créer une instance de NewsModel à partir d'une Map
  factory NewsModel.fromMap(Map<String, dynamic> map) {
    return NewsModel(
      id: map['id'],
      message: map['message'],
      categorie: map['categorie'],
      color: map['color'],
      sender: map['sender'],
      timestamp: map['timestamp'],
      title: map['title'] ?? '',
      description: map['description'] ?? '',
    );
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
