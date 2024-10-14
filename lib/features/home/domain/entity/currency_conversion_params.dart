
import 'package:equatable/equatable.dart';

class CurrencyConversionParams extends Equatable {
  final String from;
  final String amountToConvert;
  final String to;
  const CurrencyConversionParams({
    required this.from,
    required this.amountToConvert,
    required this.to,
  });

  @override
  List<Object> get props => [from, amountToConvert, to];
}
