import 'package:currency_converter/core/common_widgets/text_widget_common.dart';
import 'package:flutter/material.dart';

class HeadingWidget extends StatelessWidget {
  const HeadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const TextWidgetCommon(
      text: 'Currency Converter',
      fontSize: 32,
      fontWeight: FontWeight.bold,
      textColor: Colors.white,
      textAlign: TextAlign.center,
    );
  }
}
