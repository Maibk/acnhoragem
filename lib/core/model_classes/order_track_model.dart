class OrderTrackModel {
  int? id;
  String? orderDate;
  String? totalAmount;
  String? paymentMode;
  List<OrderTracking>? orderTracking;
  List<OrderItems>? orderItems;

  OrderTrackModel(
      {this.id,
        this.orderDate,
        this.totalAmount,
        this.paymentMode,
        this.orderTracking,
        this.orderItems});

  OrderTrackModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderDate = json['order_date'];
    totalAmount = json['total_amount'];
    paymentMode = json['payment_mode'];
    if (json['order_tracking'] != null) {
      orderTracking = <OrderTracking>[];
      json['order_tracking'].forEach((v) {
        orderTracking!.add(new OrderTracking.fromJson(v));
      });
    }
    if (json['order_items'] != null) {
      orderItems = <OrderItems>[];
      json['order_items'].forEach((v) {
        orderItems!.add(new OrderItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_date'] = this.orderDate;
    data['total_amount'] = this.totalAmount;
    data['payment_mode'] = this.paymentMode;
    if (this.orderTracking != null) {
      data['order_tracking'] =
          this.orderTracking!.map((v) => v.toJson()).toList();
    }
    if (this.orderItems != null) {
      data['order_items'] = this.orderItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderTracking {
  String? status;
  String? updateDate;
  String? notes;

  OrderTracking({this.status, this.updateDate, this.notes});

  OrderTracking.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    updateDate = json['update_date'];
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['update_date'] = this.updateDate;
    data['notes'] = this.notes;
    return data;
  }
}

class OrderItems {
  int? quantity;
  String? pricePerUnit;
  String? name;
  String? price;
  String? currency;
  String? image;

  OrderItems(
      {this.quantity, this.pricePerUnit, this.name, this.price, this.currency,this.image});

  OrderItems.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    pricePerUnit = json['price_per_unit'];
    name = json['name'];
    price = json['price'];
    currency = json['currency'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quantity'] = this.quantity;
    data['price_per_unit'] = this.pricePerUnit;
    data['name'] = this.name;
    data['price'] = this.price;
    data['currency'] = this.currency;
    data['image'] = this.image;
    return data;
  }
}
