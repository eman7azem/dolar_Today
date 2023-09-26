class Currency {
  final String name;
  final String sellRate;
  final String purchaseRate;

  Currency({
    required this.name,
    required this.sellRate,
    required this.purchaseRate,
  });

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      name: json['name'],
      sellRate: json['sell_rate'],
      purchaseRate: json['purchase_rate'],
    );
  }
}