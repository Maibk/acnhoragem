class ServantFormDataModel {
  bool? success;
  Data? data;
  String? message;

  ServantFormDataModel({this.success, this.data, this.message});

  ServantFormDataModel.fromJson(Map<String, dynamic> json) {
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
  int? block_id;
  int? street_id;
  int? house_id;
  String? name;
  String? fatherName;
  String? cnic;
  String? phone;
  String? block;
  String? street;
  String? houseNo;
  String? road;
  String? residentialArea;
  CnicImage? cnicImage;
  List<ServantDetail>? servantDetail;
  List<ServantFamilyDetail>? servantFamilyDetail;
  String? date;

  Data(
      {this.userId,
      this.block_id,
      this.street_id,
      this.house_id,
      this.name,
      this.fatherName,
      this.cnic,
      this.phone,
      this.block,
      this.street,
      this.houseNo,
      this.road,
      this.residentialArea,
      this.cnicImage,
      this.servantDetail,
      this.servantFamilyDetail,
      this.date});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    block_id = json['block_id'];
    street_id = json['street_id'];
    house_id = json['house_id'];
    name = json['name'];
    fatherName = json['father_name'];
    cnic = json['cnic'];
    phone = json['phone'];
    block = json['block'];
    street = json['street'];
    houseNo = json['house_no'];
    road = json['road'];
    residentialArea = json['residential_area'];
    cnicImage = json['cnic_image'] != null ? new CnicImage.fromJson(json['cnic_image']) : null;
    if (json['servant_detail'] != null) {
      servantDetail = <ServantDetail>[];
      json['servant_detail'].forEach((v) {
        servantDetail!.add(new ServantDetail.fromJson(v));
      });
    }
    if (json['servant_family_detail'] != null) {
      servantFamilyDetail = <ServantFamilyDetail>[];
      json['servant_family_detail'].forEach((v) {
        servantFamilyDetail!.add(new ServantFamilyDetail.fromJson(v));
      });
    }
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['father_name'] = this.fatherName;
    data['cnic'] = this.cnic;
    data['phone'] = this.phone;
    data['block'] = this.block;
    data['street'] = this.street;
    data['house_no'] = this.houseNo;
    data['road'] = this.road;
    data['residential_area'] = this.residentialArea;
    if (this.cnicImage != null) {
      data['cnic_image'] = this.cnicImage!.toJson();
    }
    if (this.servantDetail != null) {
      data['servant_detail'] = this.servantDetail!.map((v) => v.toJson()).toList();
    }
    if (this.servantFamilyDetail != null) {
      data['servant_family_detail'] = this.servantFamilyDetail!.map((v) => v.toJson()).toList();
    }
    data['date'] = this.date;
    return data;
  }
}

class CnicImage {
  String? ownerImage;
  String? ownerCnicFront;
  String? ownerCnicBack;

  CnicImage({this.ownerImage, this.ownerCnicFront, this.ownerCnicBack});

  CnicImage.fromJson(Map<String, dynamic> json) {
    ownerImage = json['owner_image'];
    ownerCnicFront = json['owner_cnic_front'];
    ownerCnicBack = json['owner_cnic_back'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['owner_image'] = this.ownerImage;
    data['owner_cnic_front'] = this.ownerCnicFront;
    data['owner_cnic_back'] = this.ownerCnicBack;
    return data;
  }
}

class ServantDetail {
  String? servantName;
  String? servantFather;
  String? servantCnic;
  String? servantPhone;
  String? servantHouse;
  String? servantRoad;
  String? servantStreet;
  String? servantVillage;
  String? servantPo;
  String? servantCity;
  String? servantProvince;
  String? servantImage;
  String? servantCnicFront;
  String? servantCnicBack;

  ServantDetail(
      {this.servantName,
      this.servantFather,
      this.servantCnic,
      this.servantPhone,
      this.servantHouse,
      this.servantRoad,
      this.servantStreet,
      this.servantVillage,
      this.servantPo,
      this.servantCity,
      this.servantProvince,
      this.servantImage,
      this.servantCnicFront,
      this.servantCnicBack});

  ServantDetail.fromJson(Map<String, dynamic> json) {
    servantName = json['servant_name'];
    servantFather = json['servant_father'];
    servantCnic = json['servant_cnic'];
    servantPhone = json['servant_phone'];
    servantHouse = json['servant_house'];
    servantRoad = json['servant_road'];
    servantStreet = json['servant_street'];
    servantVillage = json['servant_village'];
    servantPo = json['servant_po'];
    servantCity = json['servant_city'];
    servantProvince = json['servant_province'];
    servantImage = json['servant_image'];
    servantCnicFront = json['servant_cnic_front'];
    servantCnicBack = json['servant_cnic_back'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['servant_name'] = this.servantName;
    data['servant_father'] = this.servantFather;
    data['servant_cnic'] = this.servantCnic;
    data['servant_phone'] = this.servantPhone;
    data['servant_house'] = this.servantHouse;
    data['servant_road'] = this.servantRoad;
    data['servant_street'] = this.servantStreet;
    data['servant_village'] = this.servantVillage;
    data['servant_po'] = this.servantPo;
    data['servant_city'] = this.servantCity;
    data['servant_province'] = this.servantProvince;
    data['servant_image'] = this.servantImage;
    data['servant_cnic_front'] = this.servantCnicFront;
    data['servant_cnic_back'] = this.servantCnicBack;
    return data;
  }
}

class ServantFamilyDetail {
  String? familyName;
  String? familyOccupation;
  String? familyNic;
  String? familyCell;
  String? familyAddress;
  String? attachment;

  ServantFamilyDetail({this.familyName, this.familyOccupation, this.familyNic, this.familyCell, this.familyAddress, this.attachment});

  ServantFamilyDetail.fromJson(Map<String, dynamic> json) {
    familyName = json['family_name'];
    familyOccupation = json['family_occupation'];
    familyNic = json['family_nic'];
    familyCell = json['family_cell'];
    familyAddress = json['family_address'];
    attachment = json['attachment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['family_name'] = this.familyName;
    data['family_occupation'] = this.familyOccupation;
    data['family_nic'] = this.familyNic;
    data['family_cell'] = this.familyCell;
    data['family_address'] = this.familyAddress;
    data['attachment'] = this.attachment;
    return data;
  }
}
