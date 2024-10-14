import 'package:currency_converter/features/home/domain/entity/currency_conversion_params.dart';
import 'package:currency_converter/core/error/failure.dart';
import 'package:currency_converter/core/usecase/usecase.dart';
import 'package:currency_converter/features/home/domain/repository/currency_manager_repository.dart';
import 'package:fpdart/fpdart.dart';

class ConvertCurrencyUsecase
    implements Usecase<double?, CurrencyConversionParams> {
  final CurrencyManagerRepository currencyManagerRepository;
  ConvertCurrencyUsecase({
    required this.currencyManagerRepository,
  });

  @override
  Future<Either<Failure, double?>> call({required params}) async {
    return await currencyManagerRepository.convertCurrency(
        from: params.from,
        to: params.to,
        amountToConvert: params.amountToConvert);
  }
}
