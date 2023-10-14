import 'package:dio/dio.dart';
import 'package:dolar_today/models/bank_data.dart';
import 'package:dolar_today/models/bank_information.dart';
import 'package:dolar_today/models/gold.dart';

import '../models/blog.dart';
import '../models/currency_data.dart';

class API {
  final String baseUrl = 'https://alamana-sa.online/api';

  Future<String?> getVersion() async {
    final url = '$baseUrl/version';
    String? version;
    try {
      final dio = Dio();

      final response = await dio.get(url);
      if (response.statusCode == 200) {
        version = response.data['value'].toString(); // Assuming 'value' is the key in the JSON response.
        print("Version: $version");
      } else {
        // Handle non-200 status code as needed.
        print("========== ${response.statusCode}");
      }
    } catch (e, stackTrace) {
      print('========== Error: $e');
      print('========== Error Stack Trace: $stackTrace');
    }
    return version;
  }

  Future<BankData?> banks() async {
    final url = '$baseUrl/banks';
    BankData? data;
    try {
      final dio = Dio();

      final response = await dio.get(url);
      dio.options.connectTimeout = Duration(seconds: 30);
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

  Future<List<BlogModel>> blogs() async {
    final url = '$baseUrl/blogs';
    List<BlogModel> data = [];
    try {
      final dio = Dio();
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        final res = response.data as List<dynamic>;
        data = res.map((json) => BlogModel.fromJson(json)).toList();
      } else {
        //print("========== ${response.statusCode}");
      }
    } catch (e, stackTrace) {
      print('========== Error: $e');
      print('========== Error Stack Trace: $stackTrace');
    }
    return data;
  }

  Future<List<GoldModel>> golds() async {
    final url = '$baseUrl/golds';
    List<GoldModel> data = [];
    try {
      final dio = Dio();

      final response = await dio.get(url);
      if (response.statusCode == 200) {
        final res = response.data as List<dynamic>;
        data = res.map((json) => GoldModel.fromJson(json)).toList();
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