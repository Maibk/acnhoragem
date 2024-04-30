class Bills {
  bool? success;
  List<Data>? data;
  String? message;

  Bills({this.success, this.data, this.message});

  Bills.fromJson(Map<String, dynamic> json) {
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
  String? billMonth;
  int? beforeDueDateAmount;
  String? dueDate;
  double? afterDueDateAmount;
  String? status;
  String? downloadBill;
  String? billIssueDate;

  Data(
      {this.id,
      this.billMonth,
      this.beforeDueDateAmount,
      this.dueDate,
      this.afterDueDateAmount,
      this.status,
      this.downloadBill,
      this.billIssueDate});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    billMonth = json['bill_month'];
    beforeDueDateAmount = json['before_due_date_amount'];
    dueDate = json['due_date'];
    afterDueDateAmount = json['after_due_date_amount'];
    status = json['status'];
    downloadBill = json['download_bill'];
    billIssueDate = json['bill_issue_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bill_month'] = this.billMonth;
    data['before_due_date_amount'] = this.beforeDueDateAmount;
    data['due_date'] = this.dueDate;
    data['after_due_date_amount'] = this.afterDueDateAmount;
    data['status'] = this.status;
    data['download_bill'] = this.downloadBill;
    data['bill_issue_date'] = this.billIssueDate;
    return data;
  }
}
