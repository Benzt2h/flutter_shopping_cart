class ProductInfo {
  int id;
  String name;
  int price;
  int quantity;

  ProductInfo(
      {required this.id,
      required this.name,
      required this.price,
      this.quantity = 0});

  factory ProductInfo.fromJson(Map<String, dynamic> json) {
    return ProductInfo(
        id: json['id'], name: json['name'], price: json['price'], quantity: 0);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['quantity'] = quantity;
    return data;
  }
}
