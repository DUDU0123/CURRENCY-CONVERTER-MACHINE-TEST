
import 'package:currency_converter/core/common_widgets/text_widget_common.dart';
import 'package:currency_converter/core/constants/colors.dart';
import 'package:currency_converter/core/constants/height_width.dart';
import 'package:currency_converter/features/home/presentation/bloc/cubit/currency_manager_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrencyConvertButton extends StatelessWidget {
  const CurrencyConvertButton({
    super.key,
    required this.fromCurrency,
    required this.toCurrency,
    required this.amountController,
  });

  final String fromCurrency;
  final String toCurrency;
  final TextEditingController amountController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("Curency Data\n from: $fromCurrency\n to: $toCurrency, \namount: ${amountController.text}");
        context.read<CurrencyManagerCubit>().convertCurrency(
            from: fromCurrency,
            to: toCurrency,
            amountToConvert: amountController.text);
      },
      child: Container(
        width: screenWidth(context: context),
        decoration: BoxDecoration(
          color: const Color.fromARGB(217, 51, 82, 255),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: const Center(
          child: TextWidgetCommon(
            text: 'Convert',
            fontSize: 18,
            textColor: kWhite,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
