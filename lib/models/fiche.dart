class Fiche {
  String? dossier_id;
  String? image;
  String? note;

  Fiche({
    this.dossier_id,
    this.image,
    this.note,
  });
  // Function to convert JSON data to Medicament model
  factory Fiche.fromJson(Map<String, dynamic> json) {
    return Fiche(
      dossier_id: json['data']['comment'],
      image: json['data']['post_id'],
      note: json['data']['user_id'],
    );
  }
}