class Complaints {
  bool? success;
  List<ComplaintsData>? data;
  String? message;

  Complaints({this.success, this.data, this.message});

  Complaints.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <ComplaintsData>[];
      json['data'].forEach((v) {
        data!.add(new ComplaintsData.fromJson(v));
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

class ComplaintsData {
  int? id;
  String? complaintType;
  String? description;
  String? status;
  String? property;

  ComplaintsData({this.id, this.complaintType, this.description, this.status, this.property});

  ComplaintsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    complaintType = json['complaint_type '];
    description = json['description'];
    status = json['status'];
    property = json['property'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['complaint_type '] = this.complaintType;
    data['description'] = this.description;
    data['status'] = this.status;
    data['property'] = this.property;
    return data;
  }
}

class ComplaintTypes {
  bool? success;
  List<CompliantTypesData>? data;
  String? message;

  ComplaintTypes({this.success, this.data, this.message});

  ComplaintTypes.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <CompliantTypesData>[];
      json['data'].forEach((v) {
        data!.add(new CompliantTypesData.fromJson(v));
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

class CompliantTypesData {
  int? id;
  String? title;
  int? status;
  String? createdAt;
  Null? updatedAt;
  List<FindDepartments>? findDepartments;

  CompliantTypesData({this.id, this.title, this.status, this.createdAt, this.updatedAt, this.findDepartments});

  CompliantTypesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['find_departments'] != null) {
      findDepartments = <FindDepartments>[];
      json['find_departments'].forEach((v) {
        findDepartments!.add(new FindDepartments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.findDepartments != null) {
      data['find_departments'] = this.findDepartments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FindDepartments {
  int? id;
  String? title;
  int? depTypeId;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  FindDepartments({this.id, this.title, this.depTypeId, this.status, this.createdAt, this.updatedAt, this.deletedAt});

  FindDepartments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    depTypeId = json['dep_type_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['dep_type_id'] = this.depTypeId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
