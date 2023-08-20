class Product {
   int id;
  String name;
  String description;
  int price;
  int quantity;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
  });

  factory Product.fromMap({required Map<String, dynamic> data}) {
    return Product(
        id: data['id'],
        name: data['name'],
        description: data['description'],
        price: data['price'],
        quantity: data['quantity']);
  }
}
