class PropertiesModel {
  bool? success;
  List<Data>? data;
  String? message;

  PropertiesModel({this.success, this.data, this.message});

  PropertiesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int? id;
  String? membershipId;
  int? memberId;
  String? instCode;
  String? projCode;
  int? societyId;
  int? propertyTypeId;
  int? plotCategoryId;
  int? flatTypeId;
  String? storyType;
  String? plotNo;
  String? flatNo;
  String? shopNo;
  String? noOfRooms;
  int? sqFeet;
  int? sqYards;
  String? street;
  String? block;
  int? amount;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Data(
      {this.id,
      this.membershipId,
      this.memberId,
      this.instCode,
      this.projCode,
      this.societyId,
      this.propertyTypeId,
      this.plotCategoryId,
      this.flatTypeId,
      this.storyType,
      this.plotNo,
      this.flatNo,
      this.shopNo,
      this.noOfRooms,
      this.sqFeet,
      this.sqYards,
      this.street,
      this.block,
      this.amount,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    membershipId = json['membership_id'];
    memberId = json['member_id'];
    instCode = json['inst_code'];
    projCode = json['proj_code'];
    societyId = json['society_id'];
    propertyTypeId = json['property_type_id'];
    plotCategoryId = json['plot_category_id'];
    flatTypeId = json['flat_type_id'];
    storyType = json['story_type'];
    plotNo = json['plot_no'];
    flatNo = json['flat_no'];
    shopNo = json['shop_no'];
    noOfRooms = json['no_of_rooms'];
    sqFeet = json['sq_feet'];
    sqYards = json['sq_yards'];
    street = json['street'];
    block = json['block'];
    amount = json['amount'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['membership_id'] = this.membershipId;
    data['member_id'] = this.memberId;
    data['inst_code'] = this.instCode;
    data['proj_code'] = this.projCode;
    data['society_id'] = this.societyId;
    data['property_type_id'] = this.propertyTypeId;
    data['plot_category_id'] = this.plotCategoryId;
    data['flat_type_id'] = this.flatTypeId;
    data['story_type'] = this.storyType;
    data['plot_no'] = this.plotNo;
    data['flat_no'] = this.flatNo;
    data['shop_no'] = this.shopNo;
    data['no_of_rooms'] = this.noOfRooms;
    data['sq_feet'] = this.sqFeet;
    data['sq_yards'] = this.sqYards;
    data['street'] = this.street;
    data['block'] = this.block;
    data['amount'] = this.amount;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
