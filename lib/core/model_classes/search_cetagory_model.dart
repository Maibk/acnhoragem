class SearchCategoryModel {
  int? id;
  String? productName;
  String? price;
  String? shopName;
  String? shopLogo;
  String? categoryName;
  String? attachmentUrls;

  SearchCategoryModel(
      {this.id,
        this.productName,
        this.price,
        this.shopName,
        this.shopLogo,
        this.categoryName,
        this.attachmentUrls});

  SearchCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    price = json['price'];
    shopName = json['shop_name'];
    shopLogo = json['shop_logo'];
    categoryName = json['category_name'];
    attachmentUrls = json['attachment_urls'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_name'] = this.productName;
    data['price'] = this.price;
    data['shop_name'] = this.shopName;
    data['shop_logo'] = this.shopLogo;
    data['category_name'] = this.categoryName;
    data['attachment_urls'] = this.attachmentUrls;
    return data;
  }
}
