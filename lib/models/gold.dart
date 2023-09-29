class GoldModel {
  final int id;
  final String name;
  final double price;

  GoldModel({
    required this.id,
    required this.name,
    required this.price,
  });

  factory GoldModel.fromJson(Map<String, dynamic> json) {
    return GoldModel(
      id: json['id'] as int,
      name: json['name'] as String,
      price: double.parse(json['price']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price.toStringAsFixed(2),
    };
  }
}
