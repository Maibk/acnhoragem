class ComplainMessages {
  bool? success;
  ComplainMessagesData? data;
  String? message;

  ComplainMessages({this.success, this.data, this.message});

  ComplainMessages.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new ComplainMessagesData.fromJson(json['data']) : null;
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

class ComplainMessagesData {
  int? id;
  int? memberId;
  String? complaintType;
  String? property;
  String? description;
  String? firstDatetime;
  String? secDatetime;
  String? status;
  List<Messages>? messages;

  ComplainMessagesData(
      {this.id,
      this.memberId,
      this.complaintType,
      this.property,
      this.description,     
      this.firstDatetime,
      this.secDatetime,
      this.status,
      this.messages});

  ComplainMessagesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    memberId = json['member_id'];
    complaintType = json['complaint_type'];
    property = json['property'];
    description = json['description']; 
    firstDatetime = json['first_datetime'];
    secDatetime = json['sec_datetime'];
    status = json['status'];
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(new Messages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['member_id'] = this.memberId;
    data['complaint_type'] = this.complaintType;
    data['property'] = this.property;
    data['description'] = this.description;

    data['first_datetime'] = this.firstDatetime;
    data['sec_datetime'] = this.secDatetime;
    data['status'] = this.status;
    if (this.messages != null) {
      data['messages'] = this.messages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Messages {
  String? userName;
  String? dateTime;
  String? message;

  Messages({this.userName, this.dateTime, this.message});

  Messages.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    dateTime = json['date_time'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_name'] = this.userName;
    data['date_time'] = this.dateTime;
    data['message'] = this.message;
    return data;
  }
}
