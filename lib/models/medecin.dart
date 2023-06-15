import 'package:sofiacare/models/user.dart';

class Medic {
  String? medic_id;
  String? token;
  User? user;

  Medic({this.medic_id, this.token, this.user});

  Medic copyWith({
    String? medic_id,
    String? token,
    User? user,
  }) {
    return Medic(
      medic_id: medic_id ?? this.medic_id,
      token: token ?? this.token,
      user: user ?? this.user,
    );
  }

  static Medic fromJson(Map<String, dynamic> json) {
    return Medic(
      medic_id: json['medic_id'],
      token: json['token'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'medic_id': medic_id,
      'token': token,
      'user': user?.toJson(),
    };
  }

  @override
  String toString() {
    return 'Medic(medic_id: $medic_id, token: $token, user: $user)';
  }
}
