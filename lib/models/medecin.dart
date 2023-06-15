import 'package:sofiacare/models/user.dart';


class Medic {
  String? medic_id;
  String? token;
  User? user;

  Medic({
    this.medic_id,
    this.user,
    this.token, 
  });

  // Function to convert JSON data to Medic model
  factory Medic.fromJson(Map<String, dynamic> json) {
    return Medic(
      medic_id: json['data']['medic_id'],
      token: json['token'],
      user: User(
         id: json['data']['id'],
         name: json['data']['name'],
         image: json['data']['image'],
         email: json['data']['email'],
         token: json['token'],
      ),  
    );
  }
  
  
}
