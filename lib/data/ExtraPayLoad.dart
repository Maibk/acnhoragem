class ExtraPayload{
  Object? type;
  Object? refId;

  ExtraPayload({required this.type, required this.refId});

  ExtraPayload.fromJson(dynamic json) {
    type = json["type"];
    refId = json["ref_id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["ref_id"] = refId;
    map["type"] = type;
   return map;
  }
}
