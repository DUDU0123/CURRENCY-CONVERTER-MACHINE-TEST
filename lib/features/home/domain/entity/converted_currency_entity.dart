import 'package:equatable/equatable.dart';

class ConvertedCurrencyEntity extends Equatable {
  final double? amountToConvert;
  final String? from;
  final String? to;
  final double? convertedAmount;
  const ConvertedCurrencyEntity({
    this.amountToConvert,
    this.from,
    this.to,
    this.convertedAmount,
  });

  @override
  List<Object?> get props => [
        amountToConvert,
        from,
        to,
        convertedAmount,
      ];
}
