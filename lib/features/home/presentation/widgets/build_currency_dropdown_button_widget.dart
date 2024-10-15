import 'package:currency_converter/features/home/presentation/bloc/cubit/currency_manager_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildCurrencyDropdownButtonWidget extends StatefulWidget {
  final String label, value;
  final void Function(String?) onChanged;
  const BuildCurrencyDropdownButtonWidget({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  State<BuildCurrencyDropdownButtonWidget> createState() => _BuildCurrencyDropdownButtonWidgetState();
}

class _BuildCurrencyDropdownButtonWidgetState extends State<BuildCurrencyDropdownButtonWidget> {
  @override
  void initState() {
    context.read<CurrencyManagerCubit>().getAllCurrencies();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrencyManagerCubit, CurrencyManagerState>(
      builder: (context, state) {
        final currencies = state.allCurrenciesModel?.currencies ?? [];
        String? selectedValue = currencies.contains(widget.value) ? widget.value : null;
        return DropdownButtonFormField<String>(
          value: selectedValue,
          onChanged: widget.onChanged,
          items: currencies.map<DropdownMenuItem<String>>((String currency) {
            return DropdownMenuItem<String>(
              value: currency,
              child: Text(currency.toUpperCase()),
            );
          }).toList(),
          decoration: InputDecoration(
            labelText: widget.label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            filled: true,
            fillColor: Colors.grey.shade100,
          ),
        );
      },
    );
  }
}
