import 'package:sofiacare/models/medecin.dart';
import 'package:sofiacare/models/user.dart';

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

  Post copyWith({
    int? post_id,
    String? title,
    String? image,
    String? type,
    String? description,
    Medic? medic,
  }) {
    return Post(
      post_id: post_id ?? this.post_id,
      title: title ?? this.title,
      image: image ?? this.image,
      type: type ?? this.type,
      description: description ?? this.description,
      medic: medic ?? this.medic,
    );
  }

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      post_id: json['data']['post_id'],
      title: json['data']['title'],
      image: json['data']['image'],
      type: json['data']['type'],
      description: json['data']['description'],
      medic: Medic(
        medic_id: json['data']['medic_id'],
        user: User.fromJson(json['data']['id']),
        token: json['token'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'post_id': post_id,
      'title': title,
      'image': image,
      'type': type,
      'description': description,
      'medic': medic?.toJson(),
    };
  }

  @override
  String toString() {
    return 'Post(post_id: $post_id, title: $title, image: $image, type: $type, description: $description, medic: $medic)';
  }
}

  // Function to convert JSON data to Medicament model
  // factory Post.fromJson(Map<String, dynamic> json) {
  //   return Post(
  //       post_id: json['data']['post_id'],
  //       title: json['data']['title'],
  //       image: json['data']['image'],
  //       type: json['data']['type'],
  //       description: json['data']['description'],
  //       medic: Medic(
  //         medic_id: json['data']['medic_id'],
  //         user: json['data']['id'],
  //         token: json['token'],
  //       ));
  // }

