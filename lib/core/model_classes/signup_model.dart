class SignUpModel {
  bool? success;
  Data? data;
  String? message;

  SignUpModel({this.success, this.data, this.message});

  SignUpModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String? userCategory;
  String? name;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? presentAddress;
  int? id;
  String? token;

  Data(
      {this.userCategory,
      this.name,
      this.firstName,
      this.lastName,
      this.email,
      this.phone,
      this.presentAddress,
      this.id,
      this.token});

  Data.fromJson(Map<String, dynamic> json) {
    userCategory = json['user_category'];
    name = json['name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    presentAddress = json['present_address'];
    id = json['id'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_category'] = this.userCategory;
    data['name'] = this.name;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['present_address'] = this.presentAddress;
    data['id'] = this.id;
    data['token'] = this.token;
    return data;
  }
}
