import 'package:sofiacare/models/medecin.dart';
import 'package:sofiacare/models/user.dart';

class Patient {
  Medic? medic;
  User? user;
  String? token;
  int? patient_id;

  Patient({
    this.medic,
    this.user,
    this.token,
    this.patient_id,
  });

  // Function to convert JSON data to Patient model
  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
        token: json['token'],
        patient_id: json['patient_id'],
        user: User(
          id: json['data']['id'],
          name: json['data']['name'],
          image: json['data']['image'],
          email: json['data']['email'],
          token: json['token'],
        ),
        medic: Medic(
          medic_id: json['data']['medic_id'],
          user: json['data']['id'],
          token: json['token'],
        ));
  }
}
