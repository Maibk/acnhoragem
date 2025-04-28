import 'package:anchorageislamabad/presentation/ownerform_screen/models/owner_form_model.dart';

class TenantFormModel {
  bool? success;
  Data? data;
  String? message;

  TenantFormModel({this.success, this.data, this.message});

  TenantFormModel.fromJson(Map<String, dynamic> json) {
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
  int? userId;
  int? blockId;
  int? streetId;
  int? houseId;
  String? tenantName;
  String? fatherName;
  String? tenantCnic;
  String? tenantPhone;
  String? tenantNationality;
  String? tenantOccupation;
  String? tenantPermanentAddress;
  String? tenantBlockCommercial;
  String? tenantStreetNo;
  String? tenantHouseNo;
  String? tenantSizeOfHousePlot;
  String? name;
  String? phone;
  String? cnic;
  String? sizeOfHousePlot;
  String? presentAddress;
  String? permanentAddress;
  String? allotmentLetter;
  String? completionCertificate;
  String? privateArm;
  String? licenseNo;
  int? armQuantity;
  String? boreType;
  String? ammunitionQuantity;
  String? vehicleStatus;
  List<Vehicle>? vehicle;
  String? submitDate;
  OwnerCnicUrl? ownerCnicUrl;
  OwnerCnicUrl? tenantCnicUrl;
  OwnerCnicUrl? agentCnicUrl;
  String? tenantImageUrl;
  String? agreementImageUrl;
  String? policeRegistrationUrl;
  String? completionCertificateUrl;
  String? propertyUser;
  int? status;
  String? rejection_reason;

  Data({
    this.userId,
    this.blockId,
    this.streetId,
    this.houseId,
    this.tenantName,
    this.fatherName,
    this.tenantCnic,
    this.tenantPhone,
    this.tenantNationality,
    this.tenantOccupation,
    this.tenantPermanentAddress,
    this.tenantBlockCommercial,
    this.tenantStreetNo,
    this.tenantHouseNo,
    this.tenantSizeOfHousePlot,
    this.name,
    this.phone,
    this.cnic,
    this.sizeOfHousePlot,
    this.presentAddress,
    this.permanentAddress,
    this.allotmentLetter,
    this.completionCertificate,
    this.privateArm,
    this.licenseNo,
    this.armQuantity,
    this.boreType,
    this.ammunitionQuantity,
    this.vehicleStatus,
    this.vehicle,
    this.submitDate,
    this.ownerCnicUrl,
    this.tenantCnicUrl,
    this.agentCnicUrl,
    this.tenantImageUrl,
    this.agreementImageUrl,
    this.policeRegistrationUrl,
    this.completionCertificateUrl,
    this.propertyUser,
    this.status,
    this.rejection_reason,
  });

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    blockId = json['block_id'];
    streetId = json['street_id'];
    houseId = json['house_id'];
    tenantName = json['tenant_name'];
    fatherName = json['father_name'];
    tenantCnic = json['tenant_cnic'];
    tenantPhone = json['tenant_phone'];
    tenantNationality = json['tenant_nationality'];
    tenantOccupation = json['tenant_occupation'];
    tenantPermanentAddress = json['tenant_permanent_address'];
    tenantBlockCommercial = json['tenant_block_commercial'];
    tenantStreetNo = json['tenant_street_no'];
    tenantHouseNo = json['tenant_house_no'];
    tenantSizeOfHousePlot = json['tenant_size_of_house_plot'];
    name = json['name'];
    phone = json['phone'];
    cnic = json['cnic'];
    sizeOfHousePlot = json['size_of_house_plot'];
    presentAddress = json['present_address'];
    permanentAddress = json['permanent_address'];
    allotmentLetter = json['allotment_letter'];
    completionCertificate = json['completion_certificate'];
    privateArm = json['private_arm'];
    licenseNo = json['license_no'];
    armQuantity = json['arm_quantity'];
    boreType = json['bore_type'];
    ammunitionQuantity = json['ammunition_quantity'];
    vehicleStatus = json['vehicle_status'];
    if (json['vehicle'] != null) {
      vehicle = <Vehicle>[];
      json['vehicle'].forEach((v) {
        vehicle!.add(new Vehicle.fromJson(v));
      });
    }
    submitDate = json['submit_date'];
    ownerCnicUrl = json['owner_cnic_url'] != null ? new OwnerCnicUrl.fromJson(json['owner_cnic_url']) : null;
    tenantCnicUrl = json['tenant_cnic_url'] != null ? new OwnerCnicUrl.fromJson(json['tenant_cnic_url']) : null;
    agentCnicUrl = (json['agent_cnic_url'] != null && json['agent_cnic_url'] != "")
        ? new OwnerCnicUrl.fromJson(json['agent_cnic_url'])
        : OwnerCnicUrl(cnicBack: "", cnicFront: "");
    tenantImageUrl = json['tenant_image_url'];
    agreementImageUrl = json['agreement_image_url'];
    policeRegistrationUrl = json['police_registration_url'];
    completionCertificateUrl = json['completion_certificate_url'];
    propertyUser = json['property_user'];
    rejection_reason = json['rejection_reason'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['tenant_name'] = this.tenantName;
    data['father_name'] = this.fatherName;
    data['tenant_cnic'] = this.tenantCnic;
    data['tenant_phone'] = this.tenantPhone;
    data['tenant_nationality'] = this.tenantNationality;
    data['tenant_occupation'] = this.tenantOccupation;
    data['tenant_permanent_address'] = this.tenantPermanentAddress;
    data['tenant_block_commercial'] = this.tenantBlockCommercial;
    data['tenant_street_no'] = this.tenantStreetNo;
    data['tenant_house_no'] = this.tenantHouseNo;
    data['tenant_size_of_house_plot'] = this.tenantSizeOfHousePlot;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['cnic'] = this.cnic;
    data['size_of_house_plot'] = this.sizeOfHousePlot;
    data['present_address'] = this.presentAddress;
    data['permanent_address'] = this.permanentAddress;
    data['allotment_letter'] = this.allotmentLetter;
    data['completion_certificate'] = this.completionCertificate;
    data['private_arm'] = this.privateArm;
    data['license_no'] = this.licenseNo;
    data['arm_quantity'] = this.armQuantity;
    data['bore_type'] = this.boreType;
    data['ammunition_quantity'] = this.ammunitionQuantity;
    data['vehicle_status'] = this.vehicleStatus;
    if (this.vehicle != null) {
      data['vehicle'] = this.vehicle!.map((v) => v.toJson()).toList();
    }
    data['submit_date'] = this.submitDate;
    if (this.ownerCnicUrl != null) {
      data['owner_cnic_url'] = this.ownerCnicUrl!.toJson();
    }
    if (this.tenantCnicUrl != null) {
      data['tenant_cnic_url'] = this.tenantCnicUrl!.toJson();
    }
    if (this.agentCnicUrl != null) {
      data['agent_cnic_url'] = this.agentCnicUrl!.toJson();
    }
    data['tenant_image_url'] = this.tenantImageUrl;
    data['agreement_image_url'] = this.agreementImageUrl;
    data['police_registration_url'] = this.policeRegistrationUrl;
    data['completion_certificate_url'] = this.completionCertificateUrl;
    data['property_user'] = this.propertyUser;
    data['status'] = this.status;
    return data;
  }
}

class OwnerCnicUrl {
  String? cnicFront;
  String? cnicBack;

  OwnerCnicUrl({this.cnicFront, this.cnicBack});

  OwnerCnicUrl.fromJson(Map<String, dynamic> json) {
    cnicFront = json['cnic_front'];
    cnicBack = json['cnic_back'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cnic_front'] = this.cnicFront;
    data['cnic_back'] = this.cnicBack;
    return data;
  }
}
