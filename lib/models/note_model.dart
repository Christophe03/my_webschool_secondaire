import 'dart:convert';

class NoteModel {
  int? semestre;
  String? matiere;
  int? credit;
  double? moyenne;
  int? moyennebase;
  String? notes;

  NoteModel({
    this.semestre,
    this.matiere,
    this.credit,
    this.moyenne,
    this.moyennebase,
    this.notes,
  });

  // Exemple de données statiques
  static List<NoteModel> generateSampleData() {
    return [
      NoteModel(
        semestre: 1,
        matiere: "Mathématiques",
        credit: 3,
        moyenne: 15.5,
        moyennebase: 10,
        notes: "Bon travail !",
      ),
      NoteModel(
        semestre: 1,
        matiere: "Physique",
        credit: 4,
        moyenne: 12.0,
        moyennebase: 10,
        notes: "Besoin d'améliorer.",
      ),
      NoteModel(
        semestre: 2,
        matiere: "Informatique",
        credit: 5,
        moyenne: 17.0,
        moyennebase: 10,
        notes: "Excellent résultat !",
      ),
      // Ajoutez d'autres instances si nécessaire
    ];
  }

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      semestre: json['semestre'],
      matiere: json['matiere'],
      credit: json['credit'] ?? 0,
      moyenne: json['moyenne'] ?? 0.0,
      moyennebase: json['base'] ?? 0,
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'semestre': semestre,
      'matiere': matiere,
      'credit': credit,
      'moyenne': moyenne,
      'base': moyennebase,
      'notes': notes,
    };
  }

  String toJson() => json.encode(toMap());
}
