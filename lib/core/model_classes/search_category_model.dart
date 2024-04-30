class SearchCategoryModel {
  int? id;
  String? productName;
  String? productDetail;
  String? price;
  String? shopName;
  String? shopLogo;
  String? categoryName;
  String? attachmentUrls;
  String? averageRating;
  int? reviewCount;
  int? shopProductCount;

  SearchCategoryModel(
      {this.id,
        this.productName,
        this.productDetail,
        this.price,
        this.shopName,
        this.shopLogo,
        this.categoryName,
        this.attachmentUrls,
        this.averageRating,
        this.reviewCount,
        this.shopProductCount});

  SearchCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    productDetail = json['product_detail'];
    price = json['price'];
    shopName = json['shop_name'];
    shopLogo = json['shop_logo'];
    categoryName = json['category_name'];
    attachmentUrls = json['attachment_urls'];
    averageRating = json['average_rating'];
    reviewCount = json['review_count'];
    shopProductCount = json['shop_product_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_name'] = this.productName;
    data['product_detail'] = this.productDetail;
    data['price'] = this.price;
    data['shop_name'] = this.shopName;
    data['shop_logo'] = this.shopLogo;
    data['category_name'] = this.categoryName;
    data['attachment_urls'] = this.attachmentUrls;
    data['average_rating'] = this.averageRating;
    data['review_count'] = this.reviewCount;
    data['shop_product_count'] = this.shopProductCount;
    return data;
  }
}
