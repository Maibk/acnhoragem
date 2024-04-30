class CategoryModel {
  int? id;
  String? name;
  String? image;
  int? productionCount;
  int? isFeatured;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  CategoryModel(
      {this.id,
        this.name,
        this.image,
        this.productionCount,
        this.isFeatured,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    productionCount = json['production_count'];
    isFeatured = json['is_featured'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['is_featured'] = this.isFeatured;
    data['production_count'] = this.productionCount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
