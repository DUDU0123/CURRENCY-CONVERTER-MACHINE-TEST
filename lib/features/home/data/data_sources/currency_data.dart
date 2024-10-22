import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:currency_converter/core/exception/exceptions.dart';
import 'package:currency_converter/features/home/data/model/currency_model.dart';
import 'package:http/http.dart' as http;
import 'package:currency_converter/core/constants/api_constants.dart';

abstract interface class CurrencyData {
  Future<CurrencyModel> getAllCurrencies();
  Future<CurrencyModel> fetchCurrenciesFromFallback(String url);
  Future<double>? convertCurrency({
    required String? from,
    required String? to,
    required String amountToConvert,
  });
}

class CurrencyDataImpl extends CurrencyData {
  final http.Client client;
  CurrencyDataImpl({
    required this.client,
  });
   @override
  Future<CurrencyModel> getAllCurrencies() async {
    try {
      final response = await client.get(Uri.parse(ApiEndPoints.apiUrl));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        return CurrencyModel.fromJson(json: data);
      } else {
        final response =
            await fetchCurrenciesFromFallback(ApiEndPoints.fallBackUrl);
        return response;
      }
    } catch (e) {
      log(e.toString());
      throw ServerException(message: 'An unexpected error occured');
    }
  }

  @override
  Future<CurrencyModel> fetchCurrenciesFromFallback(String url) async {
    final response = await client.get(Uri.parse(ApiEndPoints.fallBackUrl));

    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        return CurrencyModel.fromJson(json: data);
      } else {
        throw ServerException(message: 'Unable to find currencies');
      }
    } catch (e) {
      throw ServerException(message: 'An unexpected error occured');
    }
  }
  @override
  Future<double>? convertCurrency({
    required String? from,
    required String? to,
    required String amountToConvert,
  }) async {
    try {
      if (from != null && to != null && amountToConvert.isNotEmpty) {
        final response =
            await client.get(Uri.parse(ApiEndPoints.conversionEndPoint(fromCurrency: from)));

        if (response.statusCode == 200) {
          final Map<String, dynamic> fromMap = jsonDecode(response.body)[from];
          if (fromMap.containsKey(to)) {
            double rate = fromMap[to];
            return (rate * double.parse(amountToConvert)).round().toDouble();
          } else {
            throw ServerException(message: 'Invalid target currency');
          }
        } else {
          throw ServerException(message: 'Unable to convert currency');
        }
      } else {
        throw ServerException(message: 'Provide valid data');
      }
    } on HttpException catch (_, stackTrace) {
      log("StackTrace $stackTrace");
      throw ServerException(message: 'Check your network connection');
    } catch (e, stackTrace) {
      log("StackTrace $stackTrace");
      throw Exception(e.toString());
    }
  }
}
