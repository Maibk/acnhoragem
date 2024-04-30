class OrderModel {
  int? id;
  String? orderDate;
  String? totalAmount;
  String? paymentMode;
  List<Items>? items;

  OrderModel(
      {this.id,
        this.orderDate,
        this.totalAmount,
        this.paymentMode,
        this.items});

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderDate = json['order_date'];
    totalAmount = json['total_amount'];
    paymentMode = json['payment_mode'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_date'] = this.orderDate;
    data['total_amount'] = this.totalAmount;
    data['payment_mode'] = this.paymentMode;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  int? id;
  int? quantity;
  String? pricePerUnit;
  String? name;
  String? image;

  Items({this.id, this.quantity, this.pricePerUnit, this.name, this.image});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    pricePerUnit = json['price_per_unit'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quantity'] = this.quantity;
    data['price_per_unit'] = this.pricePerUnit;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}
