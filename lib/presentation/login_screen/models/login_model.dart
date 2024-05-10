/// This class defines the variables used in the [login_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class LoginModel {
  bool? success;
  LoginData? data;
  String? message;

  LoginModel({this.success, this.data, this.message});

  LoginModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new LoginData.fromJson(json['data']) : null;
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

class LoginData {
  int? id;
  String? acmsId;
  String? userCategory;
  int? tenantToOwnerId;
  String? name;
  String? firstName;
  String? lastName;
  String? image;
  String? email;
  int? verifyEmail;
  String? cnic;
  String? slug;
  String? phone;
  int? isAdmin;
  String? roleId;
  String? address;
  String? presentAddress;
  String? countryId;
  String? stateId;
  String? cityId;
  String? zip;
  String? permissions;
  String? departmentId;
  int? isHead;
  int? depTypeHod;
  String? forgotCode;
  int? status;
  int? appForm;
  int? appFormApproved;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? token;

  LoginData(
      {this.id,
      this.acmsId,
      this.userCategory,
      this.tenantToOwnerId,
      this.name,
      this.firstName,
      this.lastName,
      this.image,
      this.email,
      this.verifyEmail,
      this.cnic,
      this.slug,
      this.phone,
      this.isAdmin,
      this.roleId,
      this.address,
      this.presentAddress,
      this.countryId,
      this.stateId,
      this.cityId,
      this.zip,
      this.permissions,
      this.departmentId,
      this.isHead,
      this.depTypeHod,
      this.forgotCode,
      this.status,
      this.appForm,
      this.appFormApproved,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.token});

  LoginData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    acmsId = json['acms_id'];
    userCategory = json['user_category'];
    tenantToOwnerId = json['tenant_to_owner_id'];
    name = json['name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    image = json['image'];
    email = json['email'];
    verifyEmail = json['verify_email'];
    cnic = json['cnic'];
    slug = json['slug'];
    phone = json['phone'];
    isAdmin = json['is_admin'];
    roleId = json['role_id'];
    address = json['address'];
    presentAddress = json['present_address'];
    countryId = json['country_id'];
    stateId = json['state_id'];
    cityId = json['city_id'];
    zip = json['zip'];
    permissions = json['permissions'];
    departmentId = json['department_id'];
    isHead = json['is_head'];
    depTypeHod = json['dep_type_hod'];
    forgotCode = json['forgot_code'];
    status = json['status'];
    appForm = json['app_form'];
    appFormApproved = json['app_form_approved'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['acms_id'] = this.acmsId;
    data['user_category'] = this.userCategory;
    data['tenant_to_owner_id'] = this.tenantToOwnerId;
    data['name'] = this.name;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['image'] = this.image;
    data['email'] = this.email;
    data['verify_email'] = this.verifyEmail;
    data['cnic'] = this.cnic;
    data['slug'] = this.slug;
    data['phone'] = this.phone;
    data['is_admin'] = this.isAdmin;
    data['role_id'] = this.roleId;
    data['address'] = this.address;
    data['present_address'] = this.presentAddress;
    data['country_id'] = this.countryId;
    data['state_id'] = this.stateId;
    data['city_id'] = this.cityId;
    data['zip'] = this.zip;
    data['permissions'] = this.permissions;
    data['department_id'] = this.departmentId;
    data['is_head'] = this.isHead;
    data['dep_type_hod'] = this.depTypeHod;
    data['forgot_code'] = this.forgotCode;
    data['status'] = this.status;
    data['app_form'] = this.appForm;
    data['app_form_approved'] = this.appFormApproved;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['token'] = this.token;
    return data;
  }
}
