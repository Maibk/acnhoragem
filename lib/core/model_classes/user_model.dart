class UserModel {
  int? id;
  int? roleId;
  String? name;
  String? email;
  String? profileImage;
  String? emailVerifiedAt;
  String? apiToken;
  String? createdAt;
  String? updatedAt;

  UserModel(
      {this.id,
        this.roleId,
        this.name,
        this.email,
        this.profileImage,
        this.emailVerifiedAt,
        this.apiToken,
        this.createdAt,
        this.updatedAt});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roleId = json['role_id'];
    name = json['name'];
    email = json['email'];
    profileImage = json['profile_image'];
    emailVerifiedAt = json['email_verified_at'];
    apiToken = json['api_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['role_id'] = this.roleId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['profile_image'] = this.profileImage;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['api_token'] = this.apiToken;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
