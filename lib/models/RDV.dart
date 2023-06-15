class Rendvous {
  int? id;
  String? time;
  String? date;
  String? medic_id;
  String? patient_id;
  String? token;

  Rendvous({
    this.id,
    this.time,
    this.date,
    this.medic_id,
    this.patient_id,
    this.token,
  });

  // Function to convert JSON data to Rendvous model
  factory Rendvous.fromJson(Map<String, dynamic> json) {
    return Rendvous(
      id: json['data']['id'],
      time: json['data']['time'],
      date: json['data']['date'],
      medic_id: json['data']['medic_id'],
      patient_id: json['data']['patient_id'],
      token: json['token'],
    );
  }
}
