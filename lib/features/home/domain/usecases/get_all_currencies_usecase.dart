import 'package:currency_converter/core/error/failure.dart';
import 'package:currency_converter/core/usecase/usecase.dart';
import 'package:currency_converter/features/home/domain/entity/currency_entity.dart';
import 'package:currency_converter/features/home/domain/repository/currency_manager_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllCurrenciesUsecase
    implements Usecase<CurrencyEntity?, Null> {
  final CurrencyManagerRepository currencyManagerRepository;
  GetAllCurrenciesUsecase({
    required this.currencyManagerRepository,
  });

  @override
  Future<Either<Failure, CurrencyEntity?>> call({required params}) async {
    return await currencyManagerRepository.getAllCurrencies();
  }
}
