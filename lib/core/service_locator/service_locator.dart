import 'package:currency_converter/features/home/data/data_sources/currency_data.dart';
import 'package:currency_converter/features/home/data/repository/currency_manager_repository_impl.dart';
import 'package:currency_converter/features/home/domain/repository/currency_manager_repository.dart';
import 'package:currency_converter/features/home/domain/usecases/convert_currency_usecase.dart';
import 'package:currency_converter/features/home/domain/usecases/get_all_currencies_usecase.dart';
import 'package:currency_converter/features/home/presentation/bloc/cubit/currency_manager_cubit.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

GetIt serviceLocator = GetIt.instance;

initDependencies() {
  serviceLocator.registerFactory<http.Client>(
    () => http.Client(),
  );
  initCurrencyManageDependencies();
}

void initCurrencyManageDependencies() {
  serviceLocator
    ..registerFactory<CurrencyData>(
      () => CurrencyDataImpl(
        client: serviceLocator<http.Client>(),
      ),
    )
    ..registerFactory<CurrencyManagerRepository>(
      () => CurrencyManagerRepositoryImpl(
        currencyData: serviceLocator<CurrencyData>(),
      ),
    )
    ..registerFactory(
      () => GetAllCurrenciesUsecase(
        currencyManagerRepository: serviceLocator<CurrencyManagerRepository>(),
      ),
    )
    ..registerFactory(
      () => ConvertCurrencyUsecase(
        currencyManagerRepository: serviceLocator<CurrencyManagerRepository>(),
      ),
    )
    ..registerLazySingleton(
      () => CurrencyManagerCubit(
        getAllCurrenciesUsecase: serviceLocator<GetAllCurrenciesUsecase>(),
        convertCurrencyUsecase: serviceLocator<ConvertCurrencyUsecase>(),
      ),
    );
}
