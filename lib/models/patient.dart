import 'package:sofiacare/models/medecin.dart';
import 'package:sofiacare/models/user.dart';

class Patient {
  Medic? medic;
  User? user;
  String? token;
  int? patient_id;

  Patient({this.medic, this.user, this.token, this.patient_id});

  Patient copyWith({
    Medic? medic,
    User? user,
    String? token,
    int? patient_id,
  }) {
    return Patient(
      medic: medic ?? this.medic,
      user: user ?? this.user,
      token: token ?? this.token,
      patient_id: patient_id ?? this.patient_id,
    );
  }

  static Patient fromJson(Map<String, dynamic> json) {
    return Patient(
      medic: json['medic'] != null ? Medic.fromJson(json['medic']) : null,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      token: json['token'],
      patient_id: json['patient_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'medic': medic?.toJson(),
      'user': user?.toJson(),
      'token': token,
      'patient_id': patient_id,
    };
  }

  @override
  String toString() {
    return 'Patient(medic: $medic, user: $user, token: $token, patient_id: $patient_id)';
  }
}
