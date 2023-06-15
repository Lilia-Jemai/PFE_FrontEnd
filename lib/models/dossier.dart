class Dossier {
  String? nom;
  String? prenom;
  String? date_naissance;
  String? sexe;
  String? tel;
  String? email;
  String? cnam;
  String? diagnostique;
  String? medicament;
  String? symptome;
  String? description;
  String? medic_id;

  Dossier({
    this.nom,
    this.prenom,
    this.date_naissance,
    this.sexe,
    this.tel,
    this.email,
    this.cnam,
    this.diagnostique,
    this.medicament,
    this.symptome,
    this.description,
    this.medic_id,
  });
  // Function to convert JSON data to Medicament model
  factory Dossier.fromJson(Map<String, dynamic> json) {
    return Dossier(
      nom: json['data']['nom'],
      prenom: json['data']['prenom'],
      date_naissance: json['data']['date_naissance'],
      sexe: json['data']['sexe'],
      tel: json['data']['tel'],
      email: json['data']['email'],
      cnam: json['data']['diagnostique'],
      medicament: json['data']['medicament'],
      symptome: json['data']['symptome'],
      description: json['data']['description'],
      medic_id: json['data']['medic_id'],
    );
  }
}