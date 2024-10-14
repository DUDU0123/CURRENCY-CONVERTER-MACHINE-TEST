import 'package:currency_converter/core/error/failure.dart';
import 'package:currency_converter/features/home/domain/entity/currency_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class CurrencyManagerRepository {
  Future<Either<Failure, CurrencyEntity>> getAllCurrencies();
  Future<Either<Failure, double?>> convertCurrency({
    required String? from,
    required String? to,
    required String amountToConvert,
  });
}