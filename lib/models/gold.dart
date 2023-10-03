class GoldModel {
  final int id;
  final String name;
  final double price;
  final double sell;
  final DateTime? lastUpdate;

  GoldModel({
    required this.id,
    required this.name,
    required this.price,
    required this.sell,
    required this.lastUpdate
  });

  factory GoldModel.fromJson(Map<String, dynamic> json) {
    return GoldModel(
      id: json['id'] as int,
      name: json['name'] as String,
      price: double.parse(json['price']),
      sell: double.parse(json['sell']),
      lastUpdate: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price.toStringAsFixed(2),
      'sell': sell.toStringAsFixed(2),
    };
  }
}
