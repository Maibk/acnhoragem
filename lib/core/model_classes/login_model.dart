// class LoginModel {
//   int? id;
//   String? name;
//   String? email;
//   String? apiToken;
//   String? emailVerifiedAt;
//   String? profile_image;

//   LoginModel(
//       {this.id, this.name, this.email, this.apiToken, this.emailVerifiedAt,this.profile_image});

//   LoginModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     email = json['email'];
//     apiToken = json['api_token'];
//     profile_image = json['profile_image'];
//     emailVerifiedAt = json['email_verified_at'];
//   }
// //logout kr k login kro
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['email'] = this.email;
//     data['api_token'] = this.apiToken;
//     data['profile_image'] = this.profile_image;
//     data['email_verified_at'] = this.emailVerifiedAt;
//     return data;
//   }
// }
