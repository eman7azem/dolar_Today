class BankInform {
  final String name;
  final String hotline;

  BankInform({
    required this.name,
    required this.hotline,
  });

  factory BankInform.fromJson(Map<String, dynamic> json) {
    return BankInform(
      name: json['name'],
      hotline: json['hotline'],
    );
  }
}



