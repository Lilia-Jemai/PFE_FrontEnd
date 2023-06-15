import 'package:sofiacare/models/medecin.dart';
import 'package:sofiacare/models/user.dart';

class Question {
  int? question_id;
  String? question;
  User? user;
  Medic? medic;

  Question({
    this.question_id,
    this.question,
    this.medic,
    this.user,
  });
  // Function to convert JSON data to Medicament model
  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
        question_id: json['data']['question_id'],
        question: json['data']['question'],
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
