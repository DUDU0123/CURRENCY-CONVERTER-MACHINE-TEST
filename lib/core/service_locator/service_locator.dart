import 'package:currency_converter/features/home/data/data_sources/currency_data.dart';
import 'package:currency_converter/features/home/data/repository/currency_manager_repository_impl.dart';
import 'package:currency_converter/features/home/domain/repository/currency_manager_repository.dart';
import 'package:currency_converter/features/home/domain/usecases/convert_currency_usecase.dart';
import 'package:currency_converter/features/home/domain/usecases/get_all_currencies_usecase.dart';
import 'package:currency_converter/features/home/presentation/bloc/cubit/currency_manager_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

GetIt serviceLocator = GetIt.instance;

initDependencies() {
  serviceLocator.registerFactory<Dio>(
    () => Dio(),
  );
  initCurrencyManageDependencies();
}

void initCurrencyManageDependencies() {
  serviceLocator
    ..registerFactory<CurrencyData>(
      () => CurrencyDataImpl(
        dio: serviceLocator<Dio>(),
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
