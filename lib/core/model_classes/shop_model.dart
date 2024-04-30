class ShopModel {
  ShopDetails? shopDetails;
  List<Reviews>? reviews;
  List<Products>? products;

  ShopModel({this.shopDetails, this.reviews, this.products});

  ShopModel.fromJson(Map<String, dynamic> json) {
    shopDetails = json['shop_details'] != null
        ? new ShopDetails.fromJson(json['shop_details'])
        : null;
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(new Reviews.fromJson(v));
      });
    }
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.shopDetails != null) {
      data['shop_details'] = this.shopDetails!.toJson();
    }
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    }
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShopDetails {
  int? shopId;
  String? shopName;
  String? shopLogo;
  String? shopCover;
  String? shopCreatedAt;
  String? shopUpdatedAt;
  Object? shopDeletedAt;

  ShopDetails(
      {this.shopId,
        this.shopName,
        this.shopLogo,
        this.shopCover,
        this.shopCreatedAt,
        this.shopUpdatedAt,
        this.shopDeletedAt});

  ShopDetails.fromJson(Map<String, dynamic> json) {
    shopId = json['shop_id'];
    shopName = json['shop_name'];
    shopLogo = json['shop_logo'];
    shopCover = json['shop_cover'];
    shopCreatedAt = json['shop_created_at'];
    shopUpdatedAt = json['shop_updated_at'];
    shopDeletedAt = json['shop_deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shop_id'] = this.shopId;
    data['shop_name'] = this.shopName;
    data['shop_logo'] = this.shopLogo;
    data['shop_cover'] = this.shopCover;
    data['shop_created_at'] = this.shopCreatedAt;
    data['shop_updated_at'] = this.shopUpdatedAt;
    data['shop_deleted_at'] = this.shopDeletedAt;
    return data;
  }
}

class Reviews {
  int? reviewId;
  int? userId;
  int? rating;
  String? review;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;

  Reviews(
      {this.reviewId,
        this.userId,
        this.rating,
        this.review,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  Reviews.fromJson(Map<String, dynamic> json) {
    reviewId = json['review_id'];
    userId = json['user_id'];
    rating = json['rating'];
    review = json['review'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['review_id'] = this.reviewId;
    data['user_id'] = this.userId;
    data['rating'] = this.rating;
    data['review'] = this.review;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class Products {
  int? productId;
  String? productName;
  String? productImage;
  String? productPrice;
  List<String>? attachmentUrls;

  Products(
      {this.productId,
        this.productName,
        this.productImage,
        this.productPrice,
        this.attachmentUrls});

  Products.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    productImage = json['product_image'];
    productPrice = json['product_price'];
    attachmentUrls = json['attachment_urls']!=null?(json['attachment_urls'].cast<String>()):[];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['product_image'] = this.productImage;
    data['product_price'] = this.productPrice;
    data['attachment_urls'] = this.attachmentUrls;
    return data;
  }
}
