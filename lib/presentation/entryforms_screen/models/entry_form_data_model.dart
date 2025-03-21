class EntryFormDataModel {
  bool? success;
  Data? data;
  String? message;

  EntryFormDataModel({this.success, this.data, this.message});

  EntryFormDataModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? fatherName;
  String? cnic;
  String? phone;
  String? houseNo;
  String? road;
  String? street;
  String? block;
  String? residentialArea;
  String? image;
  String? cnicImageFront;
  String? cnicImageBack;
  List<SpouseDetail>? spouseDetail;
  List<ChildDetail>? childDetail;
  String? date;
  String? rejection_reason;

  Data(
      {this.name,
      this.fatherName,
      this.cnic,
      this.phone,
      this.houseNo,
      this.road,
      this.street,
      this.block,
      this.residentialArea,
      this.image,
      this.cnicImageFront,
      this.cnicImageBack,
      this.spouseDetail,
      this.childDetail,
      this.rejection_reason,
      this.date});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    fatherName = json['father_name'];
    cnic = json['cnic'];
    phone = json['phone'];
    houseNo = json['house_no'];
    road = json['road'];
    street = json['street'];
    block = json['block'];
    residentialArea = json['residential_area'];
    image = json['image'];
    cnicImageFront = json['cnic_image_front'];
    cnicImageBack = json['cnic_image_back'];
    if (json['spouse_detail'] != null) {
      spouseDetail = <SpouseDetail>[];
      json['spouse_detail'].forEach((v) {
        spouseDetail!.add(new SpouseDetail.fromJson(v));
      });
    }
    if (json['child_detail'] != null) {
      childDetail = <ChildDetail>[];
      json['child_detail'].forEach((v) {
        childDetail!.add(new ChildDetail.fromJson(v));
      });
    }
    date = json['date'];
    rejection_reason = json['rejection_reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['father_name'] = this.fatherName;
    data['cnic'] = this.cnic;
    data['phone'] = this.phone;
    data['house_no'] = this.houseNo;
    data['road'] = this.road;
    data['street'] = this.street;
    data['block'] = this.block;
    data['residential_area'] = this.residentialArea;
    data['image'] = this.image;
    data['cnic_image_front'] = this.cnicImageFront;
    data['cnic_image_back'] = this.cnicImageBack;
    if (this.spouseDetail != null) {
      data['spouse_detail'] = this.spouseDetail!.map((v) => v.toJson()).toList();
    }
    if (this.childDetail != null) {
      data['child_detail'] = this.childDetail!.map((v) => v.toJson()).toList();
    }
    data['date'] = this.date;
    return data;
  }
}

class SpouseDetail {
  String? spouseName;
  String? spouseCnic;
  String? spousePhone;
  String? spouseHouse;
  String? spouseRoad;
  String? spouseStreet;
  String? spouseVillage;
  String? spousePo;
  String? spouseCity;
  String? spouseProvince;
  String? spouseImage;
  String? spouseCnicFront;
  String? spouseCnicBack;

  SpouseDetail(
      {this.spouseName,
      this.spouseCnic,
      this.spousePhone,
      this.spouseHouse,
      this.spouseRoad,
      this.spouseStreet,
      this.spouseVillage,
      this.spousePo,
      this.spouseCity,
      this.spouseProvince,
      this.spouseImage,
      this.spouseCnicFront,
      this.spouseCnicBack});

  SpouseDetail.fromJson(Map<String, dynamic> json) {
    spouseName = json['spouse_name'];
    spouseCnic = json['spouse_cnic'];
    spousePhone = json['spouse_phone'];
    spouseHouse = json['spouse_house'];
    spouseRoad = json['spouse_road'];
    spouseStreet = json['spouse_street'];
    spouseVillage = json['spouse_village'];
    spousePo = json['spouse_po'];
    spouseCity = json['spouse_city'];
    spouseProvince = json['spouse_province'];
    spouseImage = json['spouse_image'];
    spouseCnicFront = json['spouse_cnic_front'];
    spouseCnicBack = json['spouse_cnic_back'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['spouse_name'] = this.spouseName;
    data['spouse_cnic'] = this.spouseCnic;
    data['spouse_phone'] = this.spousePhone;
    data['spouse_house'] = this.spouseHouse;
    data['spouse_road'] = this.spouseRoad;
    data['spouse_street'] = this.spouseStreet;
    data['spouse_village'] = this.spouseVillage;
    data['spouse_po'] = this.spousePo;
    data['spouse_city'] = this.spouseCity;
    data['spouse_province'] = this.spouseProvince;
    data['spouse_image'] = this.spouseImage;
    data['spouse_cnic_front'] = this.spouseCnicFront;
    data['spouse_cnic_back'] = this.spouseCnicBack;
    return data;
  }
}

class ChildDetail {
  String? childName;
  String? childCnic;
  String? childPhone;
  String? childHouse;
  String? childRoad;
  String? childStreet;
  String? childVillage;
  String? childPo;
  String? childCity;
  String? childProvince;
  String? childImage;
  String? childCnicFront;
  String? childCnicBack;

  ChildDetail(
      {this.childName,
      this.childCnic,
      this.childPhone,
      this.childHouse,
      this.childRoad,
      this.childStreet,
      this.childVillage,
      this.childPo,
      this.childCity,
      this.childProvince,
      this.childImage,
      this.childCnicFront,
      this.childCnicBack});

  ChildDetail.fromJson(Map<String, dynamic> json) {
    childName = json['child_name'];
    childCnic = json['child_cnic'];
    childPhone = json['child_phone'];
    childHouse = json['child_house'];
    childRoad = json['child_road'];
    childStreet = json['child_street'];
    childVillage = json['child_village'];
    childPo = json['child_po'];
    childCity = json['child_city'];
    childProvince = json['child_province'];
    childImage = json['child_image'];
    childCnicFront = json['child_cnic_front'];
    childCnicBack = json['child_cnic_back'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['child_name'] = this.childName;
    data['child_cnic'] = this.childCnic;
    data['child_phone'] = this.childPhone;
    data['child_house'] = this.childHouse;
    data['child_road'] = this.childRoad;
    data['child_street'] = this.childStreet;
    data['child_village'] = this.childVillage;
    data['child_po'] = this.childPo;
    data['child_city'] = this.childCity;
    data['child_province'] = this.childProvince;
    data['child_image'] = this.childImage;
    data['child_cnic_front'] = this.childCnicFront;
    data['child_cnic_back'] = this.childCnicBack;
    return data;
  }
}
