class Specialite {
  String? nom;

  Specialite({
    this.nom,
  });

  factory Specialite.fromJson(Map<String, dynamic> json) {
    return Specialite(
      nom: json['data']['nom'],
    );
  }
}
