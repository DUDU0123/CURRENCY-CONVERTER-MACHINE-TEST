import 'package:currency_converter/features/home/domain/entity/currency_entity.dart';

class CurrencyModel extends CurrencyEntity {
  const CurrencyModel({super.currencies});

  factory CurrencyModel.fromJson({required Map<String, dynamic> json}) {
    List<String> currencies = json.keys.map((key) => key.toString()).toList();
    return CurrencyModel(currencies: currencies);
  }

  CurrencyModel copyWith({List<String>? currencies}) {
    return CurrencyModel(currencies: currencies ?? this.currencies);
  }
}
