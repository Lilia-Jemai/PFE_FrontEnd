class Medicament {
  String? period;
  int? dossier_id;

  Medicament({
    this.period,
    this.dossier_id,
  });

  // Function to convert JSON data to Medicament model
  factory Medicament.fromJson(Map<String, dynamic> json) {
    return Medicament(
      period: json['data']['period'],
      dossier_id: json['data']['dossier_id'],
    );
  }
}