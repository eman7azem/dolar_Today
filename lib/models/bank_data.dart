import 'package:dolar_today/models/bank.dart';

import 'average.dart';

class BankData {
  final List<Bank> banks;
  final Average average;
  final DateTime? lastUpdate;

  BankData({
    required this.banks,
    required this.average,
    required this.lastUpdate
  });

  factory BankData.fromJson(Map<String, dynamic> json) {
    List<dynamic> bankList = json['banks'];
    List<Bank> banks = bankList.map((bank) => Bank.fromJson(bank)).toList();

    return BankData(
      banks: banks,
      average: Average.fromJson(json['average']),
      lastUpdate: json['last_update'] != null ? DateTime.parse(json['last_update']) : null,
    );
  }
}