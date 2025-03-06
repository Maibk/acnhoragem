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
  String? house_no;
  String? present_address;

  Data({this.id, this.name, this.fatherName, this.cnic, this.phone, this.houseNo, this.status, this.rank, this.house_no, this.present_address});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] ?? json['tenant_name'];
    fatherName = json['father_name'];
    cnic = json['cnic'] ?? json['tenant_cnic'];
    phone = json['phone'] ?? json['tenant_phone'];
    houseNo = json['house_no'] ?? json['tenant_house_no']; ;
    status = json['status'];
    rank = json['rank'];
    house_no = json['house_no'];
    present_address = json['present_address'];
  }
}
