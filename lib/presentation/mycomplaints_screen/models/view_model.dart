class ViewComplaintModel {
  bool? success;
  ViewModelData? data;
  String? message;

  ViewComplaintModel({this.success, this.data, this.message});

  ViewComplaintModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new ViewModelData.fromJson(json['data']) : null;
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

class ViewModelData {
  int? id;
  int? memberId;
  String? complaintType;
  String? property;
  String? description;
  List<String>? attachment;
  String? firstDatetime;
  String? secDatetime;
  String? status;


  ViewModelData(
      {this.id,
      this.memberId,
      this.complaintType,
      this.property,
      this.description,
      this.attachment,
      this.firstDatetime,
      this.secDatetime,
      this.status,
      });

  ViewModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    memberId = json['member_id'];
    complaintType = json['complaint_type'];
    property = json['property'];
    description = json['description'];
    attachment = json['attachment'].cast<String>();
    firstDatetime = json['first_datetime'];
    secDatetime = json['sec_datetime'];
    status = json['status'];
  
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['member_id'] = this.memberId;
    data['complaint_type'] = this.complaintType;
    data['property'] = this.property;
    data['description'] = this.description;
    data['attachment'] = this.attachment;
    data['first_datetime'] = this.firstDatetime;
    data['sec_datetime'] = this.secDatetime;
    data['status'] = this.status;

    return data;
  }
}
