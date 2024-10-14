part of 'currency_manager_cubit.dart';

class CurrencyManagerState extends Equatable {
  CurrencyManagerState({
    this.allCurrenciesModel,
    this.convertedResult,
    this.message,
    this.fromCurrency = 'usd',
    this.toCurrency ='eur',
  });
  final CurrencyEntity? allCurrenciesModel;
  final double? convertedResult;
  final String? message;
  String fromCurrency;
  String toCurrency;
  @override
  List<Object> get props => [
        message ?? '',
        convertedResult ?? 0.0,
        allCurrenciesModel ?? const CurrencyEntity(),toCurrency,fromCurrency
      ];

  CurrencyManagerState copyWith({
    CurrencyEntity? allCurrenciesModel,
    double? convertedResult,
    String? message,
    String? fromCurrency,
    String? toCurrency,
  }) {
    return CurrencyManagerState(
      allCurrenciesModel: allCurrenciesModel ?? this.allCurrenciesModel,
      convertedResult: convertedResult ?? this.convertedResult,
      message: message ?? this.message,
      fromCurrency: fromCurrency ?? this.fromCurrency,
      toCurrency: toCurrency ?? this.toCurrency,
    );
  }
}

final class CurrencyManagerInitial extends CurrencyManagerState {}
