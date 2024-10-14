import 'package:currency_converter/features/home/domain/entity/currency_conversion_params.dart';
import 'package:currency_converter/features/home/domain/entity/currency_entity.dart';
import 'package:currency_converter/features/home/domain/usecases/convert_currency_usecase.dart';
import 'package:currency_converter/features/home/domain/usecases/get_all_currencies_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'currency_manager_state.dart';

class CurrencyManagerCubit extends Cubit<CurrencyManagerState> {
  final ConvertCurrencyUsecase _convertCurrencyUsecase;
  final GetAllCurrenciesUsecase _getAllCurrenciesUsecase;
  CurrencyManagerCubit({
    required GetAllCurrenciesUsecase getAllCurrenciesUsecase,
    required ConvertCurrencyUsecase convertCurrencyUsecase,
  })  : _getAllCurrenciesUsecase = getAllCurrenciesUsecase,
        _convertCurrencyUsecase = convertCurrencyUsecase,
        super(CurrencyManagerInitial());

  Future<void> getAllCurrencies() async {
    try {
      final result = await _getAllCurrenciesUsecase(params: null);
      result.fold(
        (failure) {
          emit(state.copyWith(message: failure.message));
        },
        (allCurrenciesModel) {
          emit(state.copyWith(allCurrenciesModel: allCurrenciesModel));
        },
      );
    } catch (e) {
      emit(state.copyWith(message: e.toString()));
    }
  }

  void setFrom({required String currency}) {
    emit(state.copyWith(fromCurrency: currency));
  }

  void setTo({required String currency}) {
    emit(state.copyWith(toCurrency: currency));
  }

  void convertCurrency({
    required String from,
    required String to,
    required String amountToConvert,
  }) async {
    try {
      final result = await _convertCurrencyUsecase(
        params: CurrencyConversionParams(
          from: from,
          amountToConvert: amountToConvert,
          to: to,
        ),
      );
      result.fold(
        (failure) {
          print("Fetching currencies...${failure.message}"); 
          emit(state.copyWith(message: failure.message));
        },
        (convertedResult) {
          print("Fetching currencies...$convertedResult"); 
          emit(state.copyWith(convertedResult: convertedResult));
        },
      );
    } catch (e) {
      emit(state.copyWith(message: e.toString()));
    }
  }
}
