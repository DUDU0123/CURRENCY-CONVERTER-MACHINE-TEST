part of 'currency_manager_cubit.dart';

class CurrencyManagerState extends Equatable {
  CurrencyManagerState({
    this.allCurrenciesModel,
    this.convertedResult,
    this.message,
    this.isConverted = false,
    this.fromCurrency = 'usd',
    this.toCurrency = 'eur',
    this.lastFiveConversion = const [],
  });
  final CurrencyEntity? allCurrenciesModel;
  final double? convertedResult;
  List<ConvertedCurrencyEntity> lastFiveConversion;
  final String? message;
  String fromCurrency;
  String toCurrency;
  bool isConverted;
  @override
  List<Object> get props => [
        message ?? '',
        convertedResult ?? 0.0,
        allCurrenciesModel ?? const CurrencyEntity(),
        toCurrency,
        fromCurrency,
        isConverted,
        lastFiveConversion,
      ];

  CurrencyManagerState copyWith({
    CurrencyEntity? allCurrenciesModel,
    double? convertedResult,
    String? message,
    String? fromCurrency,
    bool? isConverted,
    List<ConvertedCurrencyEntity>? lastFiveConversion,
    String? toCurrency,
  }) {
    return CurrencyManagerState(
      allCurrenciesModel: allCurrenciesModel ?? this.allCurrenciesModel,
      convertedResult: convertedResult ?? this.convertedResult,
      message: message ?? this.message,
      fromCurrency: fromCurrency ?? this.fromCurrency,
      toCurrency: toCurrency ?? this.toCurrency,
      isConverted: isConverted ?? this.isConverted,
      lastFiveConversion: lastFiveConversion ?? this.lastFiveConversion,
    );
  }
}

final class CurrencyManagerInitial extends CurrencyManagerState {}
