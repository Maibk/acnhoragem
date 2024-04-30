class TopSellingModel {
  int? id;
  String? productName;
  String? price;
  String? shopName;
  String? averageRating;
  List<String>? attachmentUrls;
  int? quantitySold;

  TopSellingModel(
      {this.id,
        this.productName,
        this.price,
        this.shopName,
        this.averageRating,
        this.attachmentUrls,
        this.quantitySold});

  TopSellingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    price = json['price'];
    shopName = json['shop_name'];
    averageRating = json['average_rating'];
    attachmentUrls = json['attachment_urls'].cast<String>();
    quantitySold = json['quantity_sold'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_name'] = this.productName;
    data['price'] = this.price;
    data['shop_name'] = this.shopName;
    data['average_rating'] = this.averageRating;
    data['attachment_urls'] = this.attachmentUrls;
    data['quantity_sold'] = this.quantitySold;
    return data;
  }
}
