import 'package:dio/dio.dart';
import 'package:dolar_today/models/bank_data.dart';
import 'package:dolar_today/models/bank_information.dart';

import '../models/currency_data.dart';

class API {
  final String baseUrl = 'https://alamana-sa.online/api';

  Future<BankData?> banks() async {
    final url = '$baseUrl/banks';
    BankData? data;
    try {
      final dio = Dio();

      final response = await dio.get(url);
      if (response.statusCode == 200) {
        data = BankData.fromJson(response.data);
        print("bank ${data.average.sell}");
      } else {
        //print("========== ${response.statusCode}");
      }
    } catch (e, stackTrace) {
      print('========== Error: $e');
      print('========== Error Stack Trace: $stackTrace');
    }
    return data;
  }

  Future<CurrencyData?> bankInformation(int id) async {
    final url = '$baseUrl/bank/$id';
    CurrencyData? data;
    try {
      final dio = Dio();

      final response = await dio.get(url);
      if (response.statusCode == 200) {
        data = CurrencyData.fromJson(response.data);
        print("bank ${data.bank.hotline}");
      } else {
        //print("========== ${response.statusCode}");
      }
    } catch (e, stackTrace) {
      print('========== Error: $e');
      print('========== Error Stack Trace: $stackTrace');
    }
    return data;
  }

}