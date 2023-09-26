class Average {
  final String sell;
  final String purchase;

  Average({
    required this.sell,
    required this.purchase,
  });

  factory Average.fromJson(Map<String, dynamic> json) {
    return Average(
      sell: json['sell'],
      purchase: json['purchase'],
    );
  }
}
