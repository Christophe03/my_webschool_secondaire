class EcheanceModel {
  int? id;
  int? ordre;
  String? recu;
  String? date;
  String? date_reglement;
  double? net;
  double? montant_paye;
  String? est_solde;

  EcheanceModel({
    this.id,
    this.ordre,
    this.recu,
    this.date,
    this.date_reglement,
    this.net,
    this.montant_paye,
    this.est_solde,
  });

  // Exemple de données statiques
  static List<EcheanceModel> generateSampleData() {
    return [
      EcheanceModel(
        id: 1,
        ordre: 1,
        recu: "Reçu 001",
        date: "2024-01-01",
        date_reglement: "2024-01-10",
        net: 100.0,
        montant_paye: 50.0,
        est_solde: "Non",
      ),
      EcheanceModel(
        id: 2,
        ordre: 2,
        recu: "Reçu 002",
        date: "2024-02-01",
        date_reglement: "2024-02-10",
        net: 200.0,
        montant_paye: 200.0,
        est_solde: "Oui",
      ),
      // Ajoutez d'autres instances si nécessaire
    ];
  }

  factory EcheanceModel.fromJson(Map<String, dynamic> json) {
    return EcheanceModel(
      id: json['id'],
      ordre: json['ordre'],
      recu: json['recu'],
      date: json['date'],
      date_reglement: json['date_reglement'],
      net: json['net'] ?? 0,
      montant_paye: json['montant_paye'] ?? 0,
      est_solde: json['est_solde'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ordre': ordre,
      'recu': recu,
      'date': date,
      'date_reglement': date_reglement,
      'net': net,
      'montant_paye': montant_paye,
      'est_solde': est_solde,
    };
  }
}
