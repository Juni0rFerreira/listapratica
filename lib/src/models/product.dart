class Product {
  String id;
  double amount;
  String category;
  String product;
  bool isComprado;

  Product({
    required this.id,
    required this.amount,
    required this.category,
    required this.product,
    required this.isComprado,
  });

  Product.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        amount = map["amount"],
        category = map["category"],
        product = map["product"],
        isComprado = map["isComprado"];

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "amount": amount,
      "category": category,
      "product": product,
      "isComprado": isComprado,
    };
  }
}
