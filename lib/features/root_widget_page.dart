import 'package:currency_converter/config/routes/app_routes.dart';
import 'package:currency_converter/config/routes/routes_name.dart';
import 'package:currency_converter/core/network/connection_checker.dart';
import 'package:currency_converter/core/service_locator/service_locator.dart';
import 'package:currency_converter/features/home/presentation/bloc/cubit/currency_manager_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RootWidgetPage extends StatefulWidget {
  const RootWidgetPage({super.key});

  @override
  State<RootWidgetPage> createState() => _RootWidgetPageState();
}

class _RootWidgetPageState extends State<RootWidgetPage> {
  @override
  void initState() {
    ConnectionChecker.listenForConnectionChanges(context: context);
    super.initState();
  }

  @override
  void dispose() {
    ConnectionChecker.cancelConnectionSubscription();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<CurrencyManagerCubit>()..getAllCurrencies(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: RoutesName.homePage,
        routes: AppRoutes.routes,
      ),
    );
  }
}
