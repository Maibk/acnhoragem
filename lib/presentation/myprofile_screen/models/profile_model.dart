class ProfileModel {
  int? id;
  String? acmsId;
  String? userCategory;
  String? name;
  String? firstName;
  String? lastName;
  String? image;
  String? email;
  int? verifyEmail;
  String? cnic;
  String? phone;
  String? address;
  String? presentAddress;
  String? countryId;
  String? stateId;
  String? cityId;
  String? zip;
  int? status;
  int? appForm;

  ProfileModel(
      {this.id,
      this.acmsId,
      this.userCategory,
      this.name,
      this.firstName,
      this.lastName,
      this.image,
      this.email,
      this.verifyEmail,
      this.cnic = "",
      this.phone = "",
      this.address = "",
      this.presentAddress = "",
      this.countryId,
      this.stateId,
      this.cityId,
      this.zip,
      this.status,
      this.appForm});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    acmsId = json['acms_id'];
    userCategory = json['user_category'];
    name = json['name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    image = json['image'];
    email = json['email'];
    verifyEmail = json['verify_email'];
    cnic = json['cnic'];
    phone = json['phone'];
    address = json['address'];
    presentAddress = json['present_address'];
    countryId = json['country_id'];
    stateId = json['state_id'];
    cityId = json['city_id'];
    zip = json['zip'];
    status = json['status'];
    appForm = json['app_form'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['acms_id'] = this.acmsId;
    data['user_category'] = this.userCategory;
    data['name'] = this.name;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['image'] = this.image;
    data['email'] = this.email;
    data['verify_email'] = this.verifyEmail;
    data['cnic'] = this.cnic;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['present_address'] = this.presentAddress;
    data['country_id'] = this.countryId;
    data['state_id'] = this.stateId;
    data['city_id'] = this.cityId;
    data['zip'] = this.zip;
    data['status'] = this.status;
    data['app_form'] = this.appForm;
    return data;
  }
}

// class UserData {

  
//   static UserData data = UserData();


//   String get id => map['id'] as String? ?? "";
//   String get acmsId => map['acms_id'] as String? ?? "";
//   String get userCategory => map['user_category'] as String? ?? "";
//   String get name => map['name'] as String? ?? "";
//   String get firstName => map['first_name'] as String? ?? "";
//   String get lastName => map['last_name'] as String? ?? "";
//   String get image => map['image'] as String? ?? "";
//   String get email => map['email'] as String? ?? "";
//   String get verifyEmail => map['verify_email'] as String? ?? "";
//   String get cnic => map['cnic'] as String? ?? "";
//   String get phone => map['phone'] as String? ?? "";
//   String get address => map['address'] as String? ?? "";
//   String get presentAddress => map['present_address'] as String? ?? "";
//   String get countryId => map['country_id'] as String? ?? "";
//   String get stateId => map['state_id'] as String? ?? "";
//   String get cityId => map['city_id'] as String? ?? "";
//   String get zip => map['zip'] as String? ?? "";
//   String get status => map['status'] as String? ?? "";
//   String get appForm => map['app_form'] as String? ?? "";

//   Map<String, dynamic> map;
//   UserData({this.map = const {}});

 
// }
