import 'package:currency_converter/core/common_widgets/text_widget_common.dart';
import 'package:currency_converter/core/constants/colors.dart';
import 'package:flutter/material.dart';

Widget lastFiveConversionTitleWidget() {
  return const TextWidgetCommon(
    text: "Last Conversions",
    textColor: kWhite,
    fontWeight: FontWeight.w500,
    fontSize: 20,
  );
}
