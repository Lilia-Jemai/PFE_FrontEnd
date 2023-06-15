class User {
  int? id;
  String? name;
  String? image;
  String? email;
  String? token;

  User({
    this.id,
    this.name,
    this.image,
    this.email,
    this.token,
  });

  User copyWith({
    int? id,
    String? name,
    String? image,
    String? email,
    String? token,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      email: email ?? this.email,
      token: token ?? this.token,
    );
  }

  static User fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      email: json['email'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'email': email,
      'token': token,
    };
  }

  @override
  String toString() {
    return 'User(id: $id, name: $name, image: $image, email: $email, token: $token)';
  }
}
