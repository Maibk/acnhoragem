class AllFormsListModel {
  bool? success;
  List<Data>? data;
  String? message;

  AllFormsListModel({this.success, this.data, this.message});

  AllFormsListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class Data {
  int? id;
  String? name;
  String? fatherName;
  String? cnic;
  String? phone;
  String? houseNo;
  String? status;
  String? rank;

  Data({this.id, this.name, this.fatherName, this.cnic, this.phone, this.houseNo, this.status, this.rank});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    fatherName = json['father_name'];
    cnic = json['cnic'];
    phone = json['phone'];
    houseNo = json['house_no'];
    status = json['status'];
    rank = json['rank'];
  }
}
