import 'package:flutter/material.dart';

class OwnerFormModel {
  bool? success;
  Data? data;
  String? message;

  OwnerFormModel({this.success, this.data, this.message});

  OwnerFormModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? phone;
  String? cnic;
  String? nationality;
  String? occupation;
  String? presentAddress;
  String? permanentAddress;
  String? blockCommercial;
  String? streetNo;
  String? houseNo;
  String? total_wives;
  String? total_children;
  String? sizeOfHousePlot;
  String? allotmentLetter;
  String? completionCertificate;
  String? construction_status;
  String? privateArm;
  String? licenseNo;
  int? armQuantity;
  String? boreType;
  String? ammunitionQuantity;
  String? vehicleStatus;
  List<Vehicle>? vehicle;
  String? copyAllotmentLetter;
  String? copyApprovalBuildingPlan;
  String? copyCompletionCertificate;
  String? allotmentLetterUrl;
  String? approvalBuildingPlanUrl;
  String? completionCertificateUrl;
  int? status;
  String? rejection_reason;

  Data(
      {this.userId,
      this.name,
      this.phone,
      this.cnic,
      this.nationality,
      this.occupation,
      this.presentAddress,
      this.permanentAddress,
      this.blockCommercial,
      this.streetNo,
      this.construction_status,
      this.houseNo,
      this.sizeOfHousePlot,
      this.allotmentLetter,
      this.completionCertificate,
      this.privateArm,
      this.licenseNo,
      this.armQuantity,
      this.boreType,
      this.ammunitionQuantity,
      this.vehicleStatus,
      this.total_wives,
      this.total_children,
      this.vehicle,
      this.copyAllotmentLetter,
      this.copyApprovalBuildingPlan,
      this.copyCompletionCertificate,
      this.allotmentLetterUrl,
      this.approvalBuildingPlanUrl,
      this.completionCertificateUrl,
      this.rejection_reason,
      this.status});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    phone = json['phone'];
    cnic = json['cnic'];
    nationality = json['nationality'];
    occupation = json['occupation'];
    presentAddress = json['present_address'];
    permanentAddress = json['permanent_address'];
    blockCommercial = json['block_commercial'];
    construction_status = json['construction_status'];
    streetNo = json['street_no'];
    houseNo = json['house_no'];
    sizeOfHousePlot = json['size_of_house_plot'];
    allotmentLetter = json['allotment_letter'];
    completionCertificate = json['completion_certificate'];
    privateArm = json['private_arm'];
    licenseNo = json['license_no'];
    armQuantity = json['arm_quantity'];
    total_children = json['total_children'];
    total_wives = json['total_wives'];
    boreType = json['bore_type'];
    ammunitionQuantity = json['ammunition_quantity'];
    vehicleStatus = json['vehicle_status'];
    if (json['vehicle'] != null) {
      vehicle = <Vehicle>[];
      json['vehicle'].forEach((v) {
        vehicle!.add(new Vehicle.fromJson(v));
      });
    }
    copyAllotmentLetter = json['copy_allotment_letter'];
    copyApprovalBuildingPlan = json['copy_approval_building_plan'];
    copyCompletionCertificate = json['copy_completion_certificate'];
    allotmentLetterUrl = json['allotment_letter_url'];
    approvalBuildingPlanUrl = json['approval_building_plan_url'];
    completionCertificateUrl = json['completion_certificate_url'];
    status = json['status'];
    rejection_reason = json['rejection_reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['cnic'] = this.cnic;
    data['nationality'] = this.nationality;
    data['occupation'] = this.occupation;
    data['present_address'] = this.presentAddress;
    data['permanent_address'] = this.permanentAddress;
    data['block_commercial'] = this.blockCommercial;
    data['street_no'] = this.streetNo;
    data['house_no'] = this.houseNo;
    data['size_of_house_plot'] = this.sizeOfHousePlot;
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
    data['copy_allotment_letter'] = this.copyAllotmentLetter;
    data['copy_approval_building_plan'] = this.copyApprovalBuildingPlan;
    data['copy_completion_certificate'] = this.copyCompletionCertificate;
    data['allotment_letter_url'] = this.allotmentLetterUrl;
    data['approval_building_plan_url'] = this.approvalBuildingPlanUrl;
    data['completion_certificate_url'] = this.completionCertificateUrl;
    data['status'] = this.status;
    return data;
  }
}

class Vehicle {
  String? vehicleType;
  String? registration;
  String? color;
  String? stickerNo;
  TextEditingController vehicleTypeController = TextEditingController();
  TextEditingController registrationController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController stickerNoController = TextEditingController();

  String? etag;

  Vehicle({this.vehicleType, this.registration, this.color, this.stickerNo, this.etag});

  Vehicle.fromJson(Map<String, dynamic> json) {
    vehicleType = json['vehicle_type'];
    registration = json['registration'];
    color = json['color'];
    stickerNo = json['sticker_no'];
    etag = json['etag'];
    vehicleTypeController.text = vehicleType ?? "";
    registrationController.text = registration ?? "";  
    colorController.text = color ?? "";    
    stickerNoController.text = stickerNo ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vehicle_type'] = this.vehicleType;
    data['registration'] = this.registration;
    data['color'] = this.color;
    data['sticker_no'] = this.stickerNo;
    data['etag'] = this.etag;
    return data;
  }
}
