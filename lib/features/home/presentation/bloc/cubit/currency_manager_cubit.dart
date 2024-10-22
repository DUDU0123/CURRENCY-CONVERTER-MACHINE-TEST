import 'package:currency_converter/features/home/domain/entity/converted_currency_entity.dart';
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
          emit(state.copyWith(
            allCurrenciesModel: allCurrenciesModel,
          ));
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
          // print("Fetching currencies...${failure.message}");
          emit(state.copyWith(message: failure.message, isConverted: false));
        },
        (convertedResult) {
          final convertedCurrency = ConvertedCurrencyEntity(
            amountToConvert: double.parse(amountToConvert),
            convertedAmount: convertedResult,
            from: from,
            to: to,
          );
          // take the already stored list and now converted currency data
          final updatedConversions = [
            ...state.lastFiveConversion,
            convertedCurrency
          ];
          emit(state.copyWith(
            convertedResult: convertedResult,
            isConverted: true,
          ));
          // call the last five conversion get method here
          getLastFiveConversion(convertedCurrenciesList: updatedConversions);
        },
      );
    } catch (e) {
      emit(state.copyWith(message: e.toString()));
    }
  }
  // method for get the last five conversion
  void getLastFiveConversion(
      {required List<ConvertedCurrencyEntity> convertedCurrenciesList}) {
    try {
      List<ConvertedCurrencyEntity> lastFiveConversion = [];
      if (convertedCurrenciesList.length <= 5) {
        lastFiveConversion = [...convertedCurrenciesList];
      } else {
        lastFiveConversion = convertedCurrenciesList.sublist(
            convertedCurrenciesList.length - 5, convertedCurrenciesList.length);
      }
      emit(state.copyWith(lastFiveConversion: lastFiveConversion));
    } catch (e) {
      emit(state.copyWith(message: e.toString()));
    }
  }
}
