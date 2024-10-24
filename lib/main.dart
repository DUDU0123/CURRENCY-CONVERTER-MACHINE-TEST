import 'package:currency_converter/core/service_locator/service_locator.dart';
import 'package:currency_converter/features/home/presentation/bloc/cubit/currency_manager_cubit.dart';
import 'package:currency_converter/features/root_widget_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initDependencies();
  runApp(
    BlocProvider(
      create: (context) =>
          serviceLocator<CurrencyManagerCubit>()..getAllCurrencies(),
      child:
       const RootWidgetPage(),
    ),
  );
}
