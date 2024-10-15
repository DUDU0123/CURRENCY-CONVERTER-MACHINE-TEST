import 'dart:developer';

import 'package:currency_converter/core/exception/exceptions.dart';
import 'package:fpdart/fpdart.dart';

import 'package:currency_converter/core/error/failure.dart';
import 'package:currency_converter/features/home/data/data_sources/currency_data.dart';
import 'package:currency_converter/features/home/domain/entity/currency_entity.dart';
import 'package:currency_converter/features/home/domain/repository/currency_manager_repository.dart';

class CurrencyManagerRepositoryImpl implements CurrencyManagerRepository {
  final CurrencyData currencyData;
  CurrencyManagerRepositoryImpl({
    required this.currencyData,
  });
  @override
  Future<Either<Failure, double?>> convertCurrency(
      {required String? from,
      required String? to,
      required String amountToConvert}) async {
    try {
      final convertedCurrency = await currencyData.convertCurrency(
        from: from,
        to: to,
        amountToConvert: amountToConvert,
      );
      print("Convereted currency: $convertedCurrency");
      return right(convertedCurrency);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CurrencyEntity>> getAllCurrencies() async {
    try {
      final allCurrencies = await currencyData.getAllCurrencies();
      return right(allCurrencies);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}
