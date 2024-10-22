import 'package:currency_converter/core/constants/colors.dart';
import 'package:currency_converter/core/constants/height_width.dart';
import 'package:currency_converter/features/home/presentation/bloc/cubit/currency_manager_cubit.dart';
import 'package:currency_converter/features/home/presentation/widgets/last_five_conversion_title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LastFiveConvertedResultShowWidget extends StatelessWidget {
  const LastFiveConvertedResultShowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrencyManagerCubit, CurrencyManagerState>(
      builder: (context, state) {
        if (state.lastFiveConversion.isEmpty) {
          return zeroMeasuredWidget;
        }
        return Column(
          children: [
             lastFiveConversionTitleWidget(),
                kHeight10,
            Table(
              border: TableBorder.all(
                borderRadius: BorderRadius.circular(15),
                color: kWhite,
                width: 2,
              ),
              // columnWidths: const {
              //   0: FlexColumnWidth(2),
              //   1: FlexColumnWidth(2),
              //   2: FlexColumnWidth(2),
              // },
              children: [
                const TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'From',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'To',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Converted',
                      ),
                    ),
                  ],
                ),
                ...state.lastFiveConversion.map(
                  (convertedAmountData) => TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${convertedAmountData.amountToConvert}\n${convertedAmountData.from!}',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "${convertedAmountData.amountToConvert}\n${convertedAmountData.to!}",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "${convertedAmountData.convertedAmount}",
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
