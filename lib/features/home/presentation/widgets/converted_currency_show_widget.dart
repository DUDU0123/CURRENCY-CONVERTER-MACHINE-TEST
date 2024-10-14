import 'package:currency_converter/core/common_widgets/text_widget_common.dart';
import 'package:currency_converter/core/constants/colors.dart';
import 'package:currency_converter/features/home/presentation/bloc/cubit/currency_manager_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConvertedCurrencyShowWidget extends StatelessWidget {
  const ConvertedCurrencyShowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrencyManagerCubit, CurrencyManagerState>(
      builder: (context, state) {
        return TextWidgetCommon(
          textColor: kBlack,
          fontWeight: FontWeight.bold,
          fontSize: 20,
          text: 'In ${state.toCurrency.toUpperCase()}: ${state.convertedResult}',
        );
      },
    );
  }
}
