class User {
  int? id;
  String? name;
  String? image;
  String? email;
  String? token;
  String? role; // New property

  User({
    this.id,
    this.name,
    this.image,
    this.email,
    this.token,
    this.role, // Initialize the new property
  });

  User copyWith({
    int? id,
    String? name,
    String? image,
    String? email,
    String? token,
    String? role, // Include the new property in the copyWith method
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      email: email ?? this.email,
      token: token ?? this.token,
      role: role ?? this.role,
    );
  }

  static User fromJson(Map<String, dynamic> json) {
    print(json);
    return User(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      email: json['email'],
      token: json['token'],
      role: json['role'], // Parse the 'role' property from JSON
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'email': email,
      'token': token,
      'role': role, // Include the 'role' property in the JSON representation
    };
  }

  @override
  String toString() {
    return 'User(id: $id, name: $name, image: $image, email: $email, token: $token, role: $role)';
  }
}
