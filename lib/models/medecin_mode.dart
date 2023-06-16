class Medecin {
  int? id;
  String? numTel;
  String? adresse;
  int? userId;
  int? specId;
  String? createdAt;
  String? updatedAt;
  UserModel? user;
  Spec? spec;

  Medecin(
      {this.id,
      this.numTel,
      this.adresse,
      this.userId,
      this.specId,
      this.createdAt,
      this.updatedAt,
      this.user,
      this.spec});

  Medecin.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    numTel = json['num_tel'];
    adresse = json['adresse'];
    userId = json['user_id'];
    specId = json['spec_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new UserModel.fromJson(json['user']) : null;
    spec = json['spec'] != null ? new Spec.fromJson(json['spec']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['num_tel'] = this.numTel;
    data['adresse'] = this.adresse;
    data['user_id'] = this.userId;
    data['spec_id'] = this.specId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.spec != null) {
      data['spec'] = this.spec!.toJson();
    }
    return data;
  }
}

class UserModel {
  int? id;
  String? name;
  String? role;
  String? email;
  String? emailVerifiedAt;
  String? verificationCode;
  String? verified;
  String? createdAt;
  String? updatedAt;

  UserModel(
      {this.id,
      this.name,
      this.role,
      this.email,
      this.emailVerifiedAt,
      this.verificationCode,
      this.verified,
      this.createdAt,
      this.updatedAt});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    role = json['role'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    verificationCode = json['verification_code'];
    verified = json['verified'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['role'] = this.role;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['verification_code'] = this.verificationCode;
    data['verified'] = this.verified;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Spec {
  int? id;
  String? nom;
  String? createdAt;
  String? updatedAt;

  Spec({this.id, this.nom, this.createdAt, this.updatedAt});

  Spec.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nom = json['nom'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nom'] = this.nom;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
