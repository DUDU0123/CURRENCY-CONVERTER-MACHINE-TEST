import 'dart:developer';

import 'package:currency_converter/core/exception/exceptions.dart';
import 'package:currency_converter/features/home/data/model/currency_model.dart';
import 'package:dio/dio.dart';

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
  final Dio dio;
  CurrencyDataImpl({
    required this.dio,
  });
  @override
  Future<CurrencyModel> getAllCurrencies() async {
    try {
      final response = await dio.get(ApiEndPoints.apiUrl);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        return CurrencyModel.fromJson(json:  data);
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
    final response = await dio.get(ApiEndPoints.fallBackUrl);
    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        return CurrencyModel.fromJson(json:data);
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
        final response = await dio
            .get(ApiEndPoints.conversionEndPoint(fromCurrency: from));

        if (response.statusCode == 200) {
          Map<String, dynamic> data = response.data;
          double rate = data[to] ?? 1;
          return rate * double.parse(amountToConvert);
        } else {
          throw ServerException(message: 'Unable to convert currency');
        }
      } else {
        throw ServerException(message: 'Provide valid data');
      }
    } catch (e) {
      throw ServerException(message: 'An unexpected error occured');
    }
  }
}
