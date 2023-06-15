import 'package:sofiacare/models/medecin.dart';

class Post {
  int? post_id;
  String? title;
  String? image;
  String? type;
  String? description;
  Medic? medic;

  Post({
    this.post_id,
    this.title,
    this.image,
    this.type,
    this.description,
    this.medic,
  });
  // Function to convert JSON data to Medicament model
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        post_id: json['data']['post_id'],
        title: json['data']['title'],
        image: json['data']['image'],
        type: json['data']['type'],
        description: json['data']['description'],
        medic: Medic(
          medic_id: json['data']['medic_id'],
          user: json['data']['id'],
          token: json['token'],
        ));
  }
}
