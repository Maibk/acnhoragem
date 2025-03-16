class VehicleFormDataModel {
  bool? success;
  Data? data;
  String? message;

  VehicleFormDataModel({this.success, this.data, this.message});

  VehicleFormDataModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  int? userId;
  String? name;
  String? fatherName;
  String? category;
  String? date;
  String? rank;
  String? serviceNo;
  String? cnic;
  String? officeDepartment;
  String? houseNo;
  String? roadStreet;
  String? block;
  String? cellNo;
  String? ptclNo;
  String? residentialStatus;
  String? noc;
  List<VehicleDetail>? vehicleDetail;
  List<VehicleUserDetail>? vehicleUserDetail;
  String? drivingLicenseFront;
  String? drivingLicenseBack;
  String? cnicImageFront;
  String? cnicImageBack;
  String? registrationImage;
  String? ownerImage;
  String? allotmentLetterImage;
  String? maintenanceBillImage;
  String? oldStickerImage;
  String? rejection_reason;

  Data(
      {this.id,
      this.userId,
      this.name,
      this.fatherName,
      this.category,
      this.date,
      this.rank,
      this.serviceNo,
      this.cnic,
      this.officeDepartment,
      this.houseNo,
      this.roadStreet,
      this.block,
      this.cellNo,
      this.ptclNo,
      this.residentialStatus,
      this.noc,
      this.vehicleDetail,
      this.vehicleUserDetail,
      this.drivingLicenseFront,
      this.drivingLicenseBack,
      this.cnicImageFront,
      this.cnicImageBack,
      this.registrationImage,
      this.ownerImage,
      this.allotmentLetterImage,
      this.maintenanceBillImage,
      this.rejection_reason,
      this.oldStickerImage});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    fatherName = json['father_name'];
    category = json['category'];
    date = json['date'];
    rank = json['rank'];
    serviceNo = json['service_no'];
    cnic = json['cnic'];
    officeDepartment = json['office_department'];
    houseNo = json['house_no'];
    roadStreet = json['road_street'];
    block = json['block'];
    cellNo = json['cell_no'];
    ptclNo = json['ptcl_no'];
    residentialStatus = json['residential_status'];
    noc = json['noc'];
    if (json['vehicle_detail'] != null) {
      vehicleDetail = <VehicleDetail>[];
      json['vehicle_detail'].forEach((v) {
        vehicleDetail!.add(new VehicleDetail.fromJson(v));
      });
    }
    if (json['vehicle_user_detail'] != null) {
      vehicleUserDetail = <VehicleUserDetail>[];
      json['vehicle_user_detail'].forEach((v) {
        vehicleUserDetail!.add(new VehicleUserDetail.fromJson(v));
      });
    }
    drivingLicenseFront = json['driving_license_front'];
    drivingLicenseBack = json['driving_license_back'];
    cnicImageFront = json['cnic_image_front'];
    cnicImageBack = json['cnic_image_back'];
    registrationImage = json['registration_image'];
    ownerImage = json['owner_image'];
    allotmentLetterImage = json['allotment_letter_image'];
    maintenanceBillImage = json['maintenance_bill_image'];
    oldStickerImage = json['old_sticker_image'];
    rejection_reason = json['rejection_reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['father_name'] = this.fatherName;
    data['category'] = this.category;
    data['date'] = this.date;
    data['rank'] = this.rank;
    data['service_no'] = this.serviceNo;
    data['cnic'] = this.cnic;
    data['office_department'] = this.officeDepartment;
    data['house_no'] = this.houseNo;
    data['road_street'] = this.roadStreet;
    data['block'] = this.block;
    data['cell_no'] = this.cellNo;
    data['ptcl_no'] = this.ptclNo;
    data['residential_status'] = this.residentialStatus;
    data['noc'] = this.noc;
    if (this.vehicleDetail != null) {
      data['vehicle_detail'] = this.vehicleDetail!.map((v) => v.toJson()).toList();
    }
    if (this.vehicleUserDetail != null) {
      data['vehicle_user_detail'] = this.vehicleUserDetail!.map((v) => v.toJson()).toList();
    }
    data['driving_license_front'] = this.drivingLicenseFront;
    data['driving_license_back'] = this.drivingLicenseBack;
    data['cnic_image_front'] = this.cnicImageFront;
    data['cnic_image_back'] = this.cnicImageBack;
    data['registration_image'] = this.registrationImage;
    data['owner_image'] = this.ownerImage;
    data['allotment_letter_image'] = this.allotmentLetterImage;
    data['maintenance_bill_image'] = this.maintenanceBillImage;
    data['old_sticker_image'] = this.oldStickerImage;
    return data;
  }
}

class VehicleDetail {
  String? vehicleNo;
  String? vehicleMake;
  String? vehicleModel;
  String? vehicleColor;
  String? vehicleEngine;
  String? vehicleChassis;

  VehicleDetail({this.vehicleNo, this.vehicleMake, this.vehicleModel, this.vehicleColor, this.vehicleEngine, this.vehicleChassis});

  VehicleDetail.fromJson(Map<String, dynamic> json) {
    vehicleNo = json['vehicle_no'];
    vehicleMake = json['vehicle_make'];
    vehicleModel = json['vehicle_model'];
    vehicleColor = json['vehicle_color'];
    vehicleEngine = json['vehicle_engine'];
    vehicleChassis = json['vehicle_chassis'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vehicle_no'] = this.vehicleNo;
    data['vehicle_make'] = this.vehicleMake;
    data['vehicle_model'] = this.vehicleModel;
    data['vehicle_color'] = this.vehicleColor;
    data['vehicle_engine'] = this.vehicleEngine;
    data['vehicle_chassis'] = this.vehicleChassis;
    return data;
  }
}

class VehicleUserDetail {
  String? userName;
  String? userNic;
  String? userPhone;
  String? userLicenseFront;
  String? userLicenseBack;
  String? userCnicFront;
  String? userCnicBack;

  VehicleUserDetail(
      {this.userName, this.userNic, this.userPhone, this.userLicenseFront, this.userLicenseBack, this.userCnicFront, this.userCnicBack});

  VehicleUserDetail.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    userNic = json['user_nic'];
    userPhone = json['user_phone'];
    userLicenseFront = json['user_license_front'];
    userLicenseBack = json['user_license_back'];
    userCnicFront = json['user_cnic_front'];
    userCnicBack = json['user_cnic_back'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_name'] = this.userName;
    data['user_nic'] = this.userNic;
    data['user_phone'] = this.userPhone;
    data['user_license_front'] = this.userLicenseFront;
    data['user_license_back'] = this.userLicenseBack;
    data['user_cnic_front'] = this.userCnicFront;
    data['user_cnic_back'] = this.userCnicBack;
    return data;
  }
}
