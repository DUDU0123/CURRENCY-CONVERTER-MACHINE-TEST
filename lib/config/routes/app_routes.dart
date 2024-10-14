import 'package:currency_converter/config/routes/routes_name.dart';
import 'package:currency_converter/features/home/presentation/pages/currency_converter_home_page.dart';
import 'package:flutter/material.dart';

class AppRoutes{
  static Map<String, Widget Function(BuildContext)> routes = {
    RoutesName.homePage : (context)=>CurrencyConverterHomePage(),
  };
}