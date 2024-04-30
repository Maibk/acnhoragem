class DownloadableAmcForms {
  bool? success;
  List<DownloadableAmcFormsData>? data;
  String? message;

  DownloadableAmcForms({this.success, this.data, this.message});

  DownloadableAmcForms.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <DownloadableAmcFormsData>[];
      json['data'].forEach((v) {
        data!.add(new DownloadableAmcFormsData.fromJson(v));
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

class DownloadableAmcFormsData {
  int? id;
  String? types;
  String? title;
  String? buttonLink;
  int? status;
  String? createdAt;
  String? updatedAt;

  DownloadableAmcFormsData(
      {this.id,
      this.types,
      this.title,
      this.buttonLink,
      this.status,
      this.createdAt,
      this.updatedAt});

  DownloadableAmcFormsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    types = json['types'];
    title = json['title'];
    buttonLink = json['button_link'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['types'] = this.types;
    data['title'] = this.title;
    data['button_link'] = this.buttonLink;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
