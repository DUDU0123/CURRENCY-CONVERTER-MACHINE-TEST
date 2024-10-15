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
    final response = await dio.get(ApiEndPoints.fallBackUrl);
    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
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
            await dio.get(ApiEndPoints.conversionEndPoint(fromCurrency: from));

        if (response.statusCode == 200) {
          Map<String, dynamic> data = response.data;
          log("TO: $to from:  $from");
          final Map<String, dynamic> fromMap = response.data[from];
          log("From: ${response.data[from]}");
          if (fromMap.containsKey(to)) {
            double rate = data[to];
            log(name: 'Rate', rate.toString());
            return rate * double.parse(amountToConvert);
          } else {
            throw ServerException(message: 'Invalid target currency');
          }
        } else {
          throw ServerException(message: 'Unable to convert currency');
        }
      } else {
        throw ServerException(message: 'Provide valid data');
      }
    } catch (e, stackTrace) {
      log("StackTrace $stackTrace");
      throw Exception(e.toString());
    }
  }
//   @override
//   Future<double>? convertCurrency({
//   required String? from,
//   required String? to,
//   required String amountToConvert,
// }) async {
//   try {
//     if (from != null && to != null && amountToConvert.isNotEmpty) {
//       // This map should be stored as a class variable or imported from elsewhere
//         final response = await dio
//             .get(ApiEndPoints.conversionEndPoint(fromCurrency: from));
//       log(response.data);
//       if (from.toLowerCase() != from) {
//         throw ServerException(message: 'This function only supports conversion from USD');
//       }

//       if (response.data.containsKey(to.toLowerCase())) {
//         double rate = response.data[to.toLowerCase()];
//         return rate * double.parse(amountToConvert);
//       } else {
//         throw ServerException(message: 'Invalid target currency');
//       }
//     } else {
//       throw ServerException(message: 'Provide valid data');
//     }
//   } catch (e) {
//     throw Exception(e.toString());
//   }
// }
}
