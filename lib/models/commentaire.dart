import 'package:sofiacare/models/post.dart';
import 'package:sofiacare/models/user.dart';

class Comment {
  String? comment;
  Post? post;
  User? user;

  Comment({
    this.comment,
    this.post,
    this.user,
  });
  // Function to convert JSON data to Medicament model
  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      comment: json['data']['comment'],
       post: Post(
        title: json['data']['title'],
        image: json['data']['image'],
        type: json['data']['type'],
        description: json['data']['description'],),
        user: User(
          id: json['data']['id'],
        name: json['data']['name'],
        image: json['data']['image'],
        email: json['data']['email'],
        token: json['token'],
        )
      
     
    );
  }
}