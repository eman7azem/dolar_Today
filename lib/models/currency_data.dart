import 'package:dolar_today/models/currency.dart';

import 'bank_information.dart';

class CurrencyData {
  final BankInform bank;
  final List<Currency> currencies;
  final DateTime? lastUpdate;
  final String bankPrice;
  final String blackPrice;


  CurrencyData({
    required this.blackPrice,
    required this.bankPrice,
    required this.bank,
    required this.currencies,
    this.lastUpdate,
  });

  factory CurrencyData.fromJson(Map<String, dynamic> json) {
    List<dynamic> currencyList = json['currencies'];
    List<Currency> currencies = currencyList.map((currency) => Currency.fromJson(currency)).toList();

    return CurrencyData(
      bank: BankInform.fromJson(json['bank']),
      currencies: currencies,
      lastUpdate: json['last_update'] != null ? DateTime.parse(json['last_update']) : null,
      bankPrice:json['bankPrice'],
      blackPrice:json['blackPrice'],
    );
  }
}
