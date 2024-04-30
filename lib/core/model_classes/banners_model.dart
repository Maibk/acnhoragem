class bannersModel {
  int? id;
  String? url;
  String? createdAt;
  String? updatedAt;

  bannersModel({this.id, this.url, this.createdAt, this.updatedAt});

  bannersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
