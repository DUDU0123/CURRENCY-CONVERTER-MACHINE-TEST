import 'package:equatable/equatable.dart';

class CurrencyEntity extends Equatable {
  final List<String>? currencies;
  const CurrencyEntity({
    this.currencies,
  });
  @override
  List<Object?> get props => [currencies,];
}
