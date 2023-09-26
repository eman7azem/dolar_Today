class Bank {
  final int id;
  final String name;
  final String? image;
  final String dollarSellRate;
  final String dollarPurchaseRate;

  Bank({
    required this.id,
    required this.name,
    this.image,
    required this.dollarSellRate,
    required this.dollarPurchaseRate,
  });

  factory Bank.fromJson(Map<String, dynamic> json) {
    return Bank(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      dollarSellRate: json['dollar_sell_rate'],
      dollarPurchaseRate: json['dollar_purchase_rate'],
    );
  }
}



