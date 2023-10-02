class GoldModel {
  final int id;
  final String name;
  final double price;
  final DateTime? lastUpdate;

  GoldModel({
    required this.id,
    required this.name,
    required this.price,
    required this.lastUpdate
  });

  factory GoldModel.fromJson(Map<String, dynamic> json) {
    return GoldModel(
      id: json['id'] as int,
      name: json['name'] as String,
      price: double.parse(json['price']),
      lastUpdate: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
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
