import 'package:currency_converter/core/common_widgets/text_field_widget_common.dart';
import 'package:currency_converter/core/constants/colors.dart';
import 'package:currency_converter/core/constants/height_width.dart';
import 'package:currency_converter/core/utils/message_show_helper.dart';
import 'package:currency_converter/features/home/presentation/bloc/cubit/currency_manager_cubit.dart';
import 'package:currency_converter/features/home/presentation/utils/common_decoration.dart';
import 'package:currency_converter/features/home/presentation/widgets/build_currency_dropdown_button_widget.dart';
import 'package:currency_converter/features/home/presentation/widgets/converted_currency_show_widget.dart';
import 'package:currency_converter/features/home/presentation/widgets/currency_convert_button.dart';
import 'package:currency_converter/features/home/presentation/widgets/heading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrencyConverterHomePage extends StatefulWidget {
  const CurrencyConverterHomePage({super.key});

  @override
  CurrencyConverterHomePageState createState() =>
      CurrencyConverterHomePageState();
}

class CurrencyConverterHomePageState extends State<CurrencyConverterHomePage> {
  final TextEditingController amountController = TextEditingController();
  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(181, 117, 138, 255),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 16.0, vertical: 24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const HeadingWidget(),
                kHeight50,
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: BlocConsumer<CurrencyManagerCubit,
                        CurrencyManagerState>(
                      listener: (context, state) {
                        if (state.message != null) {
                          if (state.message!.isNotEmpty) {
                            MessageShowhelper.showSnackbar(
                              context: context,
                                snackBarContent: state.message!);
                          }
                        }
                      },
                      builder: (context, state) {
                        return Column(
                          children: [
                            BuildCurrencyDropdownButtonWidget(
                              label: 'From',
                              value: state.fromCurrency,
                              onChanged: (value) {
                                if (value != null) {
                                  context
                                      .read<CurrencyManagerCubit>()
                                      .setFrom(currency: value);
                                }
                              },
                            ),
                            kHeight15,
                            BuildCurrencyDropdownButtonWidget(
                              label: 'To',
                              value: state.toCurrency,
                              onChanged: (value) {
                                if (value != null) {
                                  context
                                      .read<CurrencyManagerCubit>()
                                      .setTo(currency: value);
                                }
                              },
                            ),
                            kHeight25,
                            TextFieldCommon(
                              controller: amountController,
                              keyboardType: TextInputType.number,
                              labelText: 'Amount',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: Colors.grey.shade100,
                            ),
                            kHeight25,
                            CurrencyConvertButton(
                              fromCurrency: state.fromCurrency,
                              toCurrency: state.toCurrency,
                              amountController: amountController,
                            ),
                            kHeight20,
               state.isConverted? const ConvertedCurrencyShowWidget():zeroMeasuredWidget,
                          ],
                        );
                      },
                    ),
                  ),
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
