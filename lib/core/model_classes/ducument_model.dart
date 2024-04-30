class DucumentModel {
  Terms? terms;
  Terms? privacyPolicy;

  DucumentModel({this.terms, this.privacyPolicy});

  DucumentModel.fromJson(Map<String, dynamic> json) {
    terms = json['terms'] != null ? new Terms.fromJson(json['terms']) : null;
    privacyPolicy = json['privacy_policy'] != null
        ? new Terms.fromJson(json['privacy_policy'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.terms != null) {
      data['terms'] = this.terms!.toJson();
    }
    if (this.privacyPolicy != null) {
      data['privacy_policy'] = this.privacyPolicy!.toJson();
    }
    return data;
  }
}

class Terms {
  String? heading;
  String? body;

  Terms({this.heading, this.body});

  Terms.fromJson(Map<String, dynamic> json) {
    heading = json['heading'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['heading'] = this.heading;
    data['body'] = this.body;
    return data;
  }
}
