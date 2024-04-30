class ProductModel {
  int? id;
  String? productName;
  String? productDetail;
  double? price;
  String? shopName;
  String? shopLogo;
  String? categoryName;
  List<String>? attachmentUrls;
  String? averageRating;
  int? reviewCount;
  int? shopProductCount;
  late int quantity;

  double get quantityPrice => quantity * price!;

  ProductModel(
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
      this.quantity = 0,
      this.shopProductCount});

  ProductModel.fromJson(
    Map<String, dynamic> json,
  ) {
    id = json['id'];
    productName = json['product_name'];
    productDetail = json['product_detail'];
    //price = json['price'];
    price = num.parse(json['price']).toDouble();
    shopName = json['shop_name'];
    shopLogo = json['shop_logo'];
    categoryName = json['category_name'];
    attachmentUrls = json['attachment_urls'].cast<String>();
    averageRating = json['average_rating'];
    reviewCount = json['review_count'];
    shopProductCount = json['shop_product_count'];
    quantity = json["quantity"] ?? 0;
  }

  factory ProductModel.fromOrderJson(Map map) {
    return ProductModel(
      id: map["product_id"],
      quantity: map["quantity"],
      price: num.parse(map["price_per_unit"]).toDouble(),
    );
  }

  Map<String, dynamic> toCartJson() {
    return {
      "product_id": id,
      "quantity": quantity,
      "price_per_unit": price,
    };
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_name'] = this.productName;
    data['product_detail'] = this.productDetail;
    data['price'] = this.price.toString();
    data['shop_name'] = this.shopName;
    data['shop_logo'] = this.shopLogo;
    data['category_name'] = this.categoryName;
    data['attachment_urls'] = this.attachmentUrls;
    data['average_rating'] = this.averageRating;
    data['review_count'] = this.reviewCount;
    data['shop_product_count'] = this.shopProductCount;
    data['quantity'] = quantity;
    return data;
  }
}
