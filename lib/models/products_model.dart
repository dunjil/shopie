class Product {
  final int id;
  final String item;
  final String category;
  final int unitPrice;
  final int sellingPrice;
  final String oldPrice;
  final int weight;
  final String quantity;
  final String quantityLimit;
  final String brand;
  final String code;
  final String description;
  final String staff;

  Product(
      {this.id,
      this.item,
      this.code,
      this.category,
      this.unitPrice,
      this.sellingPrice,
      this.oldPrice,
      this.weight,
      this.quantity,
      this.staff,
      this.quantityLimit,
      this.brand,
      this.description});
  factory Product.fromJson(Map<String, dynamic> prod) {
    return Product(
        id: prod['id'],
        item: prod['item'],
        code: prod['code'],
        category: prod["category"],
        unitPrice: prod["unit_price"],
        sellingPrice: prod["selling_price"],
        oldPrice: prod["old_price"],
        weight: prod["weight"],
        quantity: prod["quantity"],
        staff: prod["staff"],
        quantityLimit: prod["quantity_limit"],
        brand: prod["brand"],
        description: prod["description"]);
  }
}
